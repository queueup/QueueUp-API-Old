# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :access_token
  serialize :tokens
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_one :league_profile, dependent: :destroy
  has_many :communication_data, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_many :notifications, dependent: :destroy

  after_initialize :set_default_values

  def sign_in
    tokens.push(
      key:        SecureRandom.uuid,
      expires_at: Time.zone.now + 1.year
    )
    save
    tokens.last
  end

  def set_default_values
    self.tokens ||= []
  end
end

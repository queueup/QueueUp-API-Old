# frozen_string_literal: true

class Device < ApplicationRecord
  belongs_to :user

  validates :push_token, uniqueness: true
  validates :user_token, uniqueness: true
end

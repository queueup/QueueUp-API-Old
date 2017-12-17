class User < ApplicationRecord
  attr_accessor :access_token
  serialize :tokens
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_one :league_profile
  has_many :communication_data
  has_many :devices
        
  after_initialize :set_default_values

  def sign_in
    self.tokens.push({
      key: SecureRandom.uuid,
      expires_at: Time.now + 1.year
    })
    self.save
    self.tokens.last
  end

  def set_default_values
    self.tokens ||= []
  end
end

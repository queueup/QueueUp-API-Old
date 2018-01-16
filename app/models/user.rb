class User < ApplicationRecord
  attr_accessor :access_token
  serialize :tokens
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_one :league_profile
  has_many :communication_data
  has_many :devices
  has_many :notifications
        
  after_initialize :set_default_values

  after_create :send_email

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

  private
  def send_email
    return if Rails.env === 'test'
    Mailjet::Send.create(messages: [{
      'From'=> {
        'Email'=> ENV['MAILJET_API_DEFAULT_FROM'],
        'Name'=> ENV['MAILJET_API_DEFAULT_FROM_TEXT']
      },
      'To'=> [{ 'Email'=> self.email }],
      'TemplateID'=> ENV['MAILJET_API_WELCOME_TEMP_ID'],
      'TemplateLanguage'=> true,
      'Subject'=> "Welcome aboard !"
    }])
    Mailjet::Contact_managemanycontacts.create(contacts_lists: [{ListID: ENV['MAILJET_API_LIST_ID'], action: "addnoforce"}], contacts: [{Email: self.email}])
  end
end

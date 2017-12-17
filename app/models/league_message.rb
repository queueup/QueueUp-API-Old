class LeagueMessage < ApplicationRecord
  belongs_to :league_profile
  belongs_to :league_match

  after_create :send_push_notification

  def send_push_notification
    NotificationApi.create_message_notification(self)
  end
end

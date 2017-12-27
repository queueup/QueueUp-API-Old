class LeagueMatch < ApplicationRecord
  belongs_to :swiper, class_name: 'LeagueProfile'
  belongs_to :target, class_name: 'LeagueProfile'

  has_many :league_messages, dependent: :destroy

  after_create :create_notifications

  validates :swiper_id, uniqueness: { scope: :target_id }

  validate :uniqueness_of_match

  private
  def uniqueness_of_match
    errors.add(:swiper_id, :must_be_uniq) if  LeagueMatch.exists?(swiper_id: target_id, target_id: swiper_id)
  end

  def create_notifications
    LeagueMatchNotification.new(self)
  end
end

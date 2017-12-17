class LeagueResponse < ApplicationRecord
  attr_accessor :matches
  belongs_to :swiper, class_name: 'LeagueProfile'
  belongs_to :target, class_name: 'LeagueProfile'

  validates :swiper_id, uniqueness: { scope: :target_id }

  after_create :check_match

  private
  def check_match
    if self.accepted && LeagueResponse.exists?(swiper: self.target, target: self.swiper, accepted: true)
      LeagueMatch.create(swiper: self.swiper, target: self.target)
    end
  end
end

# frozen_string_literal: true

class LeagueResponse < ApplicationRecord
  attr_accessor :matches
  belongs_to :swiper, class_name: 'LeagueProfile'
  belongs_to :target, class_name: 'LeagueProfile'

  validates :swiper_id, uniqueness: {scope: :target_id}

  after_create :check_match

  private

  def check_match
    return unless accepted && LeagueResponse.exists?(swiper: target, target: swiper, accepted: true)
    LeagueMatch.create(swiper: swiper, target: target)
  end
end

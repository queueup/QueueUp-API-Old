# frozen_string_literal: true

class LeagueProfile < ApplicationRecord
  belongs_to :user, optional: true
  has_many :league_positions, dependent: :destroy

  after_initialize :set_default_values
  before_validation :set_api_summoner
  before_create :set_initial_data
  after_create :update_ranked_data

  validates :summoner_name, presence: true, uniqueness: true
  validates :summoner_id, presence: true, uniqueness: true
  validates :region, presence: true

  def update_ranked_data
    # return self.league_positions if self.riot_updated_at > Time.zone.now - 1.day

    league_positions.destroy_all # Destroy the old records

    l = LeagueApi.new(
      summoner_name: summoner_name,
      region:        region,
      summoner_id:   summoner_id
    )
    self.riot_updated_at = Time.zone.now

    LeaguePosition.create_from_ranked_data(l.fetch_ranked_data, id)
  end

  def league_matches
    LeagueMatch.where('swiper_id = ? OR target_id = ?', id, id)
  end

  private

  def set_api_summoner
    l = LeagueApi.new(
      summoner_name: summoner_name,
      region:        region,
      summoner_id:   summoner_id
    )
    self.summoner_id ||= l.summoner_id
  end

  def set_initial_data
    l = LeagueApi.new(
      summoner_name: summoner_name,
      region:        region,
      summoner_id:   self.summoner_id
    )
    self.riot_updated_at = Time.zone.now
    self.champions = l.fetch_champions
  end

  def set_default_values
    self.champions    ||= []
    self.roles        ||= []
    self.goals        ||= []
  end
end

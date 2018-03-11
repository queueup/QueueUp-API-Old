# frozen_string_literal: true

class LeagueProfile < ApplicationRecord
  belongs_to :user, optional: true
  has_many :league_positions, dependent: :destroy

  after_initialize :set_default_values
  before_validation :set_api_summoner, on: :create
  after_create :update_ranked_data

  validates :summoner_name, presence: true, uniqueness: true
  validates :summoner_id, presence: true, uniqueness: true
  validates :region, presence: true

  def update_ranked_data
    # return league_positions if riot_updated_at > Time.zone.now - 1.day

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

  def self.custom_find_by_discord(discord_tag)
    DiscordUser.custom_find_by_discord(discord_tag)&.league_profile
  end

  def self.custom_find_by_summoner(region, summoner_name)
    lp = LeagueProfile.where(
      'LOWER(summoner_name) = ? AND LOWER(region) = ?', summoner_name.downcase, region.downcase
    ).first_or_create(region: region, summoner_name: summoner_name)
    lp.reload
    lp
  end

  private

  def set_api_summoner
    l = LeagueApi.new(
      summoner_name: summoner_name,
      region:        region
    )
    self.summoner_id = l.summoner_id
    self.summoner_name = l.summoner_name
    self.profile_icon_id = l.profile_icon_id
    self.summoner_level = l.summoner_level
    self.riot_updated_at = Time.zone.now
    self.champions = l.fetch_champions
  end

  def set_default_values
    self.champions    ||= []
    self.roles        ||= []
    self.goals        ||= []
  end
end

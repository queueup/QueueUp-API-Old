class LeagueProfile < ApplicationRecord
  serialize :champions
  serialize :goals
  serialize :locales
  serialize :ranked_data
  serialize :roles

  belongs_to :user

  after_initialize :set_default_values
  before_validation :set_api_summoner
  before_create :set_initial_data

  validates :summoner_name, presence: true, uniqueness: true
  validates :summoner_id, presence: true, uniqueness: true
  validates :region, presence: true

  def update_ranked_data
    return self.ranked_data if self.riot_updated_at > Time.now - 1.day
    l = LeagueApi.new(
      summoner_name: self.summoner_name,
      region: self.region,
      summoner_id: self.summoner_id
    )
    self.riot_updated_at = Time.now
    self.ranked_data = l.get_ranked_data
  end

  def league_matches
    LeagueMatch.where('swiper_id = ? OR target_id = ?', self.id, self.id)
  end

  private
  def set_api_summoner
    l = LeagueApi.new(
      summoner_name: self.summoner_name,
      region: self.region,
      summoner_id: self.summoner_id
    )
    self.riot_updated_at = Time.now
    self.summoner_id ||= l.summoner_id
  end

  def set_initial_data
    l = LeagueApi.new(
      summoner_name: self.summoner_name,
      region: self.region,
      summoner_id: self.summoner_id
    )
    self.riot_updated_at = Time.now
    self.ranked_data = l.get_ranked_data
    self.champions = l.get_champions
  end

  def set_default_values
    self.ranked_data  ||= []
    self.champions    ||= []
    self.roles        ||= []
    self.goals        ||= []
  end
end

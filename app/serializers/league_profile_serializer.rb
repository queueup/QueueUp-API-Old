class LeagueProfileSerializer < ActiveModel::Serializer
  attributes :id, :summoner_name, :region, :champions, :roles, :goals, :locales, :description

  has_many :ranked_data

  def ranked_data
    object.league_positions
  end
end

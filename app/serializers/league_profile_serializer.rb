class LeagueProfileSerializer < ActiveModel::Serializer
  attributes :id, :summoner_name, :region, :ranked_data, :champions, :roles, :goals, :locales
end

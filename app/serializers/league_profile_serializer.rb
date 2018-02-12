# frozen_string_literal: true

class LeagueProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :summoner_name,
             :region,
             :champions,
             :roles,
             :goals,
             :locales,
             :description,
             :ranked_data,
             :riot_updated_at

  def ranked_data
    ActiveModelSerializers::SerializableResource.new(
      object.league_positions,
      each_serializer: LeaguePositionSerializer
    )
  end
end

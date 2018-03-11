# frozen_string_literal: true

class LeagueProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :summoner_name,
             :region,
             :champions,
             :roles,
             :goals,
             :locales,
             :profile_icon_id,
             :summoner_level,
             :description,
             :ranked_data,
             :riot_updated_at,
             :user_id

  def ranked_data
    ActiveModelSerializers::SerializableResource.new(
      object.league_positions,
      each_serializer: LeaguePositionSerializer
    )
  end
end

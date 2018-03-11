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
             :user_id,
             :riot_updated_at

  def champions
    object.champions.map(&:to_i)
  end

  def ranked_data
    ActiveModelSerializers::SerializableResource.new(
      object.league_positions,
      each_serializer: LeaguePositionSerializer
    )
  end
end

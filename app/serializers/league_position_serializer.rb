# frozen_string_literal: true

class LeaguePositionSerializer < ActiveModel::Serializer
  attributes :id,
             :league_profile_id,
             :rank,
             :queue_type,
             :hot_streak,
             :wins,
             :veteran,
             :losses,
             :fresh_blood,
             :league_id,
             :player_or_team_name,
             :league_name,
             :tier,
             :inactive,
             :player_or_team_id,
             :league_points
end

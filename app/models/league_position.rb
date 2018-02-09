# frozen_string_literal: true

class LeaguePosition < ApplicationRecord
  belongs_to :league_profile

  def self.create_from_ranked_data(ranked_data, id)
    ranked_data.each {|data|
      LeaguePosition.create(
        league_profile_id:   id,
        rank:                data['rank'],
        queue_type:          data['queueType'],
        hot_streak:          data['hotStreak'],
        wins:                data['wins'],
        veteran:             data['veteran'],
        losses:              data['losses'],
        fresh_blood:         data['freshBlood'],
        league_id:           data['leagueId'],
        player_or_team_name: data['playerOrTeamName'],
        inactive:            data['inactive'],
        player_or_team_id:   data['playerOrTeamId'],
        league_name:         data['leagueName'],
        tier:                data['tier'],
        league_points:       data['leaguePoints']
      )
    }
  end
end

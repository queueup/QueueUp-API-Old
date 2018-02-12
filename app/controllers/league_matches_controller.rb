# frozen_string_literal: true

class LeagueMatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: @current_user.league_profile.league_matches
      .left_outer_joins(:league_messages)
      .group('league_matches.id, league_messages.created_at')
      .order('GREATEST(league_messages.created_at, league_matches.created_at) DESC')
                              .uniq(&:id), scope: {
                                current_user: @current_user
                              }
  end
end

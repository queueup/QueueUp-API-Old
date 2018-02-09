# frozen_string_literal: true

class LeagueProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: @current_user.league_profile
  end

  def show
    render json: @current_user.league_profile, serializer: LeagueSuggestionSerializer
  end

  def create
    @league_profile = LeagueProfile.new(league_profile_create_params)
    @league_profile.user = @current_user

    if @league_profile.save
      render json: @league_profile, status: :created
    else
      render json: @league_profile.errors, status: :unprocessable_entity
    end
  end

  def update
    if league_profile.update(league_profile_update_params)
      render json: league_profile
    else
      render json: league_profile.errors, status: :unprocessable_entity
    end
  end

  def ranked_data
    league_profile.update_ranked_data
    if league_profile.save
      render json: league_profile, include: 'league_profiles'
    else
      render json: league_profile.errors, status: :unprocessable_entity
    end
  end

  private

  def league_profile
    @current_user.league_profile
  end

  def league_profile_create_params
    params.permit(:summoner_name, :region)
  end

  def league_profile_update_params
    params.permit(:description, champions: [], goals: [], roles: [], locales: [])
  end
end

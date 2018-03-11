# frozen_string_literal: true

class LeagueProfilesController < ApplicationController
  before_action :authenticate_user!, except: %i[create discord discord_update summoner_name]
  before_action :authenticate_user, only: :create
  before_action :authenticate_bot!, only: %i[discord discord_update summoner_name]
  before_action :set_by_discord, only: %i[discord discord_update]

  def index
    render json: @current_user.league_profile
  end

  def show
    render json: @current_user.league_profile, serializer: LeagueSuggestionSerializer
  end

  def create
    @league_profile = LeagueProfile.where(
      'LOWER(summoner_name) = LOWER(?) AND LOWER(region) = LOWER(?)', params[:summoner_name], params[:region]
    ).first_or_create

    @league_profile.user = @current_user if @league_profile.user.nil? && !@current_user.nil?

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
    if league_profile.update_ranked_data
      render json: league_profile, include: 'league_profiles'
    else
      render json: league_profile.errors, status: :unprocessable_entity
    end
  end

  def discord
    render json: @league_profile, include: 'league_profiles'
  end

  def discord_update
    if @league_profile.update_ranked_data
      render json: @league_profile, include: 'league_profiles'
    else
      render json: @league_profile.errors, status: :unprocessable_entity
    end
  end

  def summoner_name
    @league_profile = LeagueProfile.custom_find_by_summoner(params[:region], params[:summoner_name])
    render json: @league_profile
  end

  private

  def league_profile
    @current_user.league_profile
  end

  def set_by_discord
    @league_profile = LeagueProfile.custom_find_by_discord(params[:id])
  end

  def league_profile_create_params
    params.permit(:summoner_name, :region)
  end

  def league_profile_update_params
    params.permit(:description, champions: [], goals: [], roles: [], locales: [])
  end
end

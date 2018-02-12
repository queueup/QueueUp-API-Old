# frozen_string_literal: true

class LfgLeagueProfilesController < ApplicationController
  before_action :authenticate_bot!

  def index
    @lfg_league_profiles = LfgLeagueProfile.where(created_at: (Time.zone.now - 10.minutes)..DateTime::Infinity.new)
    @lfg_league_profiles = @lfg_league_profiles.includes(:league_profile)
    @lfg_league_profiles = @lfg_league_profiles.references(:league_profile)
    if params[:region].present?
      @lfg_league_profiles = @lfg_league_profiles.where(region: params[:region])
    end

    render json: @lfg_league_profiles
  end

  def discord
    @lfg_league_profile = LfgLeagueProfile.new(league_profile: LeagueProfile.custom_find_by_discord(params[:id]))
    if @lfg_league_profile.save
      render json: @lfg_league_profile
    else
      render json: @lfg_league_profile.errors, status: :unprocessable_entity
    end
  end
end

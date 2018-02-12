# frozen_string_literal: true

class DiscordUsersController < ApplicationController
  before_action :authenticate_bot!
  before_action :set_discord_user, only: %i[show update]

  def show
    render json: @discord_user
  end

  def update
    if params[:region].present? && params[:summoner_name].present?
      @discord_user.update(
        league_profile: LeagueProfile.custom_find_by_summoner(params[:region], params[:summoner_name])
      )
    end
    render json: @discord_user
  end

  private

  def set_discord_user
    @discord_user = DiscordUser.custom_find_by_discord(params[:id])
  end
end

# frozen_string_literal: true

class LeagueMessagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @messages = LeagueMessage.where(league_match_id: params[:id])

    render json: @messages
  end

  def create
    @message = LeagueMessage.new(league_message_params)
    @message.league_profile = @current_user.league_profile

    if @message.save
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def league_message_params
    params.permit(:content, :league_match_id)
  end
end

# frozen_string_literal: true

class LeagueSuggestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Remove current_user profiles
    @league_profiles = LeagueProfile.where.not(user_id: [nil, @current_user.id])
    # Select current region
    @league_profiles = @league_profiles.where('lower(region) = ?', league_profile.region.downcase)
    # Remove already answered
    @league_profiles = @league_profiles.where(
      'league_profiles.id NOT IN (SELECT DISTINCT(target_id) FROM league_responses WHERE swiper_id = ?)',
      league_profile.id
    )
    # Filters

    @league_profiles = @league_profiles.includes(:league_positions)
    @league_profiles = @league_profiles.references(:league_positions)
    if params[:tiers].present?
      @league_profiles = @league_profiles.where('LOWER(league_positions.tier) IN (?)', params[:tiers].downcase)
    end
    if params[:champions].present?
      @league_profiles = @league_profiles.where('champions && ?', "{#{params[:champions]}}")
    end
    @league_profiles = @league_profiles.where('goals && ?', "{#{params[:goals]}}") if params[:goals].present?
    @league_profiles = @league_profiles.where('roles && ?', "{#{params[:roles]}}") if params[:roles].present?

    # Some randomness
    @league_profiles = @league_profiles.order('RANDOM()')
    @league_profiles = @league_profiles.uniq
    # "Pagination"
    @league_profiles = @league_profiles.first(10)

    render json: @league_profiles, include: '**', each_serializer: LeagueSuggestionSerializer
  end

  def accept
    create_response(true)
  end

  def decline
    create_response(false)
  end

  private

  def league_profile
    @current_user.league_profile
  end

  def create_response(response)
    @response = LeagueResponse.new(
      swiper:    league_profile,
      target_id: params[:id],
      accepted:  response
    )
    if @response.save
      @response.matches = response && LeagueResponse.exists?(
        swiper_id: params[:id],
        target_id: league_profile.id,
        accepted:  true
      )
      render json: @response
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end
end

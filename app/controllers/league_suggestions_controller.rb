class LeagueSuggestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Remove current_user profiles
    @league_profiles = LeagueProfile.where('user_id != ?', @current_user.id)
    # Select current region
    @league_profiles = @league_profiles.where('lower(region) = ?', league_profile.region.downcase)
    # Remove already answered
    @league_profiles = @league_profiles.where(
        'id NOT IN (SELECT DISTINCT(target_id) FROM league_responses WHERE swiper_id = ?)',
        league_profile.id
      )
    # Some randomness
    @league_profiles = @league_profiles.order('RANDOM()')
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
      swiper: league_profile,
      target_id: params[:id],
      accepted: response
    )
    if @response.save
      @response.matches = response && LeagueResponse.exists?(swiper_id: params[:id], target_id: league_profile.id, accepted: true)
      render json: @response
    else
      render json: @response.errors, status: :unprocessable_entity
    end
  end
end

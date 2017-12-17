require 'rails_helper'

RSpec.describe LeagueMatchesController, type: :controller do
  before(:example) do
    @profile = create(:league_profile)
    @signin_headers = @profile.user.sign_in
    @signin_headers = {
      HTTP_AUTH_UID: @profile.user.email,
      HTTP_AUTH_TOKEN: @signin_headers[:key]
    }
  end

  describe 'index' do
    it :orders_by_last_message do
      request.headers.merge!(@signin_headers)

      match_1 = create(:league_match, swiper: @profile)
      match_2 = create(:league_match, target: @profile)
      match_3 = create(:league_match, swiper: @profile)

      create(:league_message, league_match: match_1, created_at: Time.now - 3.hours)
      match_1_message = create(:league_message, league_match: match_1, created_at: Time.now)
      match_3_message = create(:league_message, league_match: match_3, created_at: Time.now - 1.hours)
      match_2_message = create(:league_message, league_match: match_2, created_at: Time.now - 2.hours)

      get :index
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.parsed_body)
      expect(json.length).to eq(3)
      expect(json[0]['id']).to eq(match_1.id)
      expect(json[0]['lastMessage']['id']).to eq(match_1_message.id)
      expect(json[1]['id']).to eq(match_3.id)
      expect(json[1]['lastMessage']['id']).to eq(match_3_message.id)
      expect(json[2]['id']).to eq(match_2.id)
      expect(json[2]['lastMessage']['id']).to eq(match_2_message.id)
    end
  end
end

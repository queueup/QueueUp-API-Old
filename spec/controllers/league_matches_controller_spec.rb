# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueMatchesController, type: :controller do
  let(:profile) { create(:league_profile) }
  let(:signin_headers) {
    {
      HTTP_AUTH_UID:   profile.user.email,
      HTTP_AUTH_TOKEN: profile.user.sign_in[:key]
    }}

  describe 'index' do
    it :orders_by_last_message do
      request.headers.merge!(signin_headers)

      match1 = create(:league_match, swiper: profile)
      match2 = create(:league_match, target: profile)
      match3 = create(:league_match, swiper: profile)

      create(:league_message, league_match: match1, created_at: Time.zone.now - 3.hours)
      match_1_message = create(:league_message, league_match: match1, created_at: Time.zone.now)
      match_3_message = create(:league_message, league_match: match3, created_at: Time.zone.now - 1.hour)
      match_2_message = create(:league_message, league_match: match2, created_at: Time.zone.now - 2.hours)

      get :index
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.parsed_body)
      expect(json.length).to eq(3)
      expect(json[0]['id']).to eq(match1.id)
      expect(json[0]['lastMessage']['id']).to eq(match_1_message.id)
      expect(json[1]['id']).to eq(match3.id)
      expect(json[1]['lastMessage']['id']).to eq(match_3_message.id)
      expect(json[2]['id']).to eq(match2.id)
      expect(json[2]['lastMessage']['id']).to eq(match_2_message.id)
    end
  end
end

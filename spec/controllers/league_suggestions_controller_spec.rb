# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueSuggestionsController, type: :controller do
  let(:profile) { create(:league_profile) }
  let(:signin_headers) {
    {
      HTTP_AUTH_UID:   profile.user.email,
      HTTP_AUTH_TOKEN: profile.user.sign_in[:key]
    }}

  describe 'index' do
    describe 'filters' do
      it :tiers do
        request.headers.merge!(signin_headers)
        create(:league_profile, summoner_name: 'Ztylez')
        create(:league_profile)
        get :index, params: {tiers: 'platinum'}
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.parsed_body)
        expect(json.length).to eq(1)
      end

      it :champions do
        request.headers.merge!(signin_headers)
        lp = create(:league_profile)
        lp.update(champions: [1, 2])
        lp = create(:league_profile)
        lp.update(champions: [3, 4])
        get :index, params: {champions: '1,2'}
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.parsed_body)
        expect(json.length).to eq(1)
      end

      it :roles do
        request.headers.merge!(signin_headers)
        create(:league_profile, roles: %w[top bottom])
        create(:league_profile, roles: ['adc'])
        get :index, params: {roles: 'top,bottom'}
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.parsed_body)
        expect(json.length).to eq(1)
      end

      it :goals do
        request.headers.merge!(signin_headers)
        create(:league_profile, goals: ['fun'])
        create(:league_profile, roles: ['win'])
        get :index, params: {roles: 'win'}
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.parsed_body)
        expect(json.length).to eq(1)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LfgLeagueProfilesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/lfg_league_profiles').to route_to('lfg_league_profiles#index')
    end

    it 'routes to #show' do
      expect(get: '/lfg_league_profiles/1').to route_to('lfg_league_profiles#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/lfg_league_profiles').to route_to('lfg_league_profiles#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/lfg_league_profiles/1').to route_to('lfg_league_profiles#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/lfg_league_profiles/1').to route_to('lfg_league_profiles#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/lfg_league_profiles/1').to route_to('lfg_league_profiles#destroy', id: '1')
    end
  end
end

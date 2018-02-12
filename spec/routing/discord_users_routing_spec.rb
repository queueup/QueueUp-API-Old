# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscordUsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/discord_users').to route_to('discord_users#index')
    end

    it 'routes to #show' do
      expect(get: '/discord_users/1').to route_to('discord_users#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/discord_users').to route_to('discord_users#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/discord_users/1').to route_to('discord_users#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/discord_users/1').to route_to('discord_users#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/discord_users/1').to route_to('discord_users#destroy', id: '1')
    end
  end
end

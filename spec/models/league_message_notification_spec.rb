# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueMessageNotification, type: :model do
  it :cancels_duplicate_notifications do
    match = create(:league_match)
    target = match.target
    swiper = match.swiper
    message = create(:league_message, league_match: match, league_profile: swiper)
    expect(target.user.notifications.new_league_message(message).size).to eq(1)
    message = create(:league_message, league_match: match, league_profile: swiper)
    expect(target.user.notifications.new_league_message(message).size).to eq(2)
    expect(target.user.notifications.new_league_message(message).pending.size).to eq(1)
    expect(target.user.notifications.new_league_message(message).canceled.size).to eq(1)
    message = create(:league_message, league_match: match, league_profile: swiper)
    expect(target.user.notifications.new_league_message(message).size).to eq(3)
    expect(target.user.notifications.new_league_message(message).pending.size).to eq(1)
    expect(target.user.notifications.new_league_message(message).canceled.size).to eq(2)
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LeagueProfile, type: :model do
  it :has_valid_factory do
    expect(build(:league_profile)).to be_valid
  end
end

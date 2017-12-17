require 'rails_helper'

RSpec.describe LeagueMessage, type: :model do
  it :has_valid_factory do
    expect(build(:league_message)).to be_valid
  end
end

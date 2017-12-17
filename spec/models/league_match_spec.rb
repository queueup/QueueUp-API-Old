require 'rails_helper'

RSpec.describe LeagueMatch, type: :model do
  it :has_valid_factory do
    expect(build(:league_match)).to be_valid
  end

  describe :validation do
    it :uniqueness do
      match = create(:league_match)

      expect(build(:league_match, swiper_id: match.swiper_id, target_id: match.target_id)).not_to be_valid
      expect(build(:league_match, swiper_id: match.target_id, target_id: match.swiper_id)).not_to be_valid
    end
  end
end

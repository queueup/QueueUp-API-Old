require 'rails_helper'

RSpec.describe LeagueResponse, type: :model do
  describe :callbacks do
    it :creates_match do
      response = create(:league_response, :accepted)
      create(:league_response, :accepted, target: response.swiper, swiper: response.target)

      expect(LeagueMatch.all.size).to eq(1)
    end
    
    it :doesnt_create_match do
      response = create(:league_response, :accepted)
      create(:league_response, :declined, target: response.swiper, swiper: response.target)

      expect(LeagueMatch.all.size).to eq(0)
    end
      
    it :doesnt_create_match do
      response = create(:league_response, :declined)
      create(:league_response, :accepted, target: response.swiper, swiper: response.target)

      expect(LeagueMatch.all.size).to eq(0)
    end
    
    it :doesnt_create_match do
      response = create(:league_response, :declined)
      create(:league_response, :declined, target: response.swiper, swiper: response.target)

      expect(LeagueMatch.all.size).to eq(0)
    end
  end
end

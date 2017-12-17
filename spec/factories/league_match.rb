FactoryBot.define do
  factory :league_match do
    swiper { build(:league_profile) }
    target { build(:league_profile) }
  end
end

FactoryBot.define do
  factory :league_message do
    content { FFaker::Lorem.paragraph }

    league_match
    league_profile
  end
end

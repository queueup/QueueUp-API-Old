# frozen_string_literal: true

FactoryBot.define do
  factory :league_message do
    content { Faker::Lorem.paragraph }

    league_match
    league_profile
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :league_response do
    association :swiper, factory: :league_profile
    association :target, factory: :league_profile

    trait :accepted do
      accepted true
    end

    trait :declined do
      accepted false
    end
  end
end

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password '12345678'
  end
end

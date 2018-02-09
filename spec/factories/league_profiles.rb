# frozen_string_literal: true

summoner_names = %w[
  SofianeLeFragile
  remi5151
  leboulet02
  EVERBLUE1
  Amarang
  infueco
  Azzyra
  Rynua
  cedouc
  Mykon
]

FactoryBot.define do
  factory :league_profile do
    sequence(:summoner_name) do |n|
      summoner_names[n % 10]
    end
    region 'euw'

    user
  end
end

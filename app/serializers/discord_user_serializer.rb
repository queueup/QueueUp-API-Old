# frozen_string_literal: true

class DiscordUserSerializer < ActiveModel::Serializer
  attributes :id
  has_one :communication_datum
  has_one :league_profile
end

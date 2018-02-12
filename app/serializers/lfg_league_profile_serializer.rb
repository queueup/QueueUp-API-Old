# frozen_string_literal: true

class LfgLeagueProfileSerializer < ActiveModel::Serializer
  attributes :id
  has_one :league_profile
end

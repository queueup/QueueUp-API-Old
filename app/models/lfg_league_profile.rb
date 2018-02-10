# frozen_string_literal: true

class LfgLeagueProfile < ApplicationRecord
  belongs_to :league_profile

  validate :once_in_period

  protected

  def once_in_period
    return unless LfgLeagueProfile.exists?([
      'league_profile_id = ? AND created_at > ?',
      league_profile_id, Time.zone.now - 10.minutes
    ])
    errors.add(:created_at, 'once in a while')
  end
end

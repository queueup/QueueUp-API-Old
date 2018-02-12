# frozen_string_literal: true

class DiscordUser < ApplicationRecord
  belongs_to :communication_datum
  belongs_to :league_profile, optional: true

  def self.custom_find_by_discord(discord)
    cd = CommunicationDatum.where(type: :discord, value: discord)
    if cd.size > 1
      ncd = cd.where.not(user_id: nil)
      datum = ncd.size.positive? ? ncd.first : cd.first
    else
      datum = cd.first_or_create
    end
    if datum.discord_user.nil?
      DiscordUser.create(communication_datum: datum, league_profile: datum.user&.league_profile)
    else
      datum.discord_user
    end
  end
end

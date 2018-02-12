# frozen_string_literal: true

class Notification < ApplicationRecord
  enum status: %i[
    pending
    seen
    canceled
  ]

  scope :canceled, -> { where(status: :canceled) }
  scope :pending, -> { where(status: :pending) }
  scope :seen, -> { where(status: :seen) }

  scope :new_league_message, ->(message) { where(verb: "league:message:new:#{message.league_match.id}") }
  scope :new_league_match, -> { where(verb: 'league:match:new') }

  belongs_to :user
end

class Notification < ApplicationRecord
  enum status: [
    :pending,
    :seen,
    :canceled
  ]

  scope :canceled, -> { where(status: :canceled) }
  scope :pending, -> { where(status: :pending) }
  scope :seen, -> { where(status: :seen) }

  scope :new_league_message, -> { where(verb: 'league:message:new') }
  scope :new_league_match, -> { where(verb: 'league:match:new') }

  belongs_to :user
end

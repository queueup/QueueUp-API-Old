# frozen_string_literal: true

class CommunicationDatum < ApplicationRecord
  belongs_to :user, optional: true
  has_one :discord_user, dependent: :destroy

  self.inheritance_column = :_type_disabled
end

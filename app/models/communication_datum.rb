# frozen_string_literal: true

class CommunicationDatum < ApplicationRecord
  belongs_to :user

  self.inheritance_column = :_type_disabled
end

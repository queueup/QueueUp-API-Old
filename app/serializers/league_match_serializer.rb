# frozen_string_literal: true

class LeagueMatchSerializer < ActiveModel::Serializer
  attributes :id

  belongs_to :league_profile
  has_many :communication_data
  has_one :last_message

  def league_profile
    object.swiper_id == scope[:current_user].league_profile.id ? object.target : object.swiper
  end

  def communication_data
    league_profile.user.communication_data
  end

  def last_message
    object.league_messages.empty? ? nil : object.league_messages.order(:created_at).last
  end
end

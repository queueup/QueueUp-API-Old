class LeagueSuggestionSerializer < ActiveModel::Serializer
  belongs_to :league_profile
  has_many :communication_data

  def league_profile
    object
  end

  def communication_data
    object.user.communication_data
  end
end

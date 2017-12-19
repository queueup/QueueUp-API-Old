class AddingDescriptionToLeagueProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :league_profiles, :description, :string, default: ''
  end
end

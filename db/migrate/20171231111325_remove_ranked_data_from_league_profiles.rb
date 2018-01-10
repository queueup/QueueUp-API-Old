class RemoveRankedDataFromLeagueProfiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :league_profiles, :ranked_data
  end
end

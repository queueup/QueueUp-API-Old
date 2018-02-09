class RemoveRankedDataFromLeagueProfiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :league_profiles, :ranked_data
    LeagueProfile.all.each do |league_profile|
      league_profile.update_ranked_data
    end
  end
end

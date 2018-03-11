class AddingLeagueProfileIconToLeagueProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :league_profiles, :profile_icon_id, :integer, default: 0
    add_column :league_profiles, :summoner_level, :integer, default: 0

    LeagueProfile.all.each do |lp|
      lp.send(:set_api_summoner)
    end
  end
end

class AddingLocalesToLeagueProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :league_profiles, :locales, :string, default: "--- []\n"
  end
end

class CreateLfgLeagueProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :lfg_league_profiles, id: :uuid do |t|
      t.belongs_to :league_profile, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

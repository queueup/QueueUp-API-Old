class CreateLeagueProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :league_profiles, id: :uuid do |t|
      t.string :summoner_name
      t.string :summoner_id
      t.string :region
      t.text :ranked_data
      t.string :roles
      t.string :goals
      t.string :champions
      t.datetime :riot_updated_at

      t.belongs_to :user, type: :uuid

      t.timestamps
    end
  end
end

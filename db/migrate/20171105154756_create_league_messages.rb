class CreateLeagueMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :league_messages, id: :uuid do |t|
      t.string :content

      t.belongs_to :league_match, type: :uuid
      t.belongs_to :league_profile, type: :uuid

      t.timestamps
    end
  end
end

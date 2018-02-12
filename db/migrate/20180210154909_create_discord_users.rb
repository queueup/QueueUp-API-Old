class CreateDiscordUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :discord_users, id: :uuid do |t|
      t.belongs_to :communication_datum, foreign_key: true, type: :uuid
      t.belongs_to :league_profile, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

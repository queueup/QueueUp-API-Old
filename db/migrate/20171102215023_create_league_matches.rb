class CreateLeagueMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :league_matches, id: :uuid do |t|
      t.belongs_to :swiper, type: :uuid
      t.belongs_to :target, type: :uuid

      t.timestamps
    end
  end
end

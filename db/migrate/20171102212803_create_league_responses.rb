class CreateLeagueResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :league_responses, id: :uuid do |t|
      t.belongs_to :swiper, type: :uuid
      t.belongs_to :target, type: :uuid
      t.boolean :accepted

      t.timestamps
    end
  end
end

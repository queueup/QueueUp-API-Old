class CreateCommunicationData < ActiveRecord::Migration[5.1]
  def change
    create_table :communication_data, id: :uuid do |t|
      t.belongs_to :user, foreign_key: true, type: :uuid
      t.string :type
      t.string :value

      t.timestamps
    end
  end
end

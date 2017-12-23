class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.string :signal_id
      t.string :verb
      t.integer :status
      t.belongs_to :user, type: :uuid

      t.timestamps
    end
  end
end

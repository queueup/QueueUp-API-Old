class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices, id: :uuid do |t|
      t.belongs_to :user, type: :uuid
      t.string :push_token
      t.string :user_token

      t.timestamps
    end
  end
end

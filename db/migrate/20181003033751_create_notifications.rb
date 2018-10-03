class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.belongs_to :player, null: false, index: true
      t.integer :icon, default: 0, null: false
      t.string :message, null: false
      t.string :url

      t.timestamps
    end
  end
end

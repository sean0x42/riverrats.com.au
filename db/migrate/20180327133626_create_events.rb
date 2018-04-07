class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.references :venue,  null: false
      t.datetime :start_at, null: false
      t.timestamps
    end
  end
end

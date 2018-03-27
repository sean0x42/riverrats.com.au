class CreateSeasons < ActiveRecord::Migration[5.1]
  def change
    create_table :seasons do |t|
      t.date :start_at, null: false
      t.date :end_at,   null: false
    end
  end
end

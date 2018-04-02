class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.belongs_to :venue,  index: true, null: false
      t.belongs_to :season, index: true, null: false
      t.timestamps
    end
  end
end

class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.belongs_to :event, null: false
      t.timestamps
    end

    create_table :referees, id: false do |t|
      t.belongs_to :game,   index: true
      t.belongs_to :player, index: true
    end
  end
end

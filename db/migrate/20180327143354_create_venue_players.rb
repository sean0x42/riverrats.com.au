class CreateVenuePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players_venues do |t|
      t.belongs_to :venue,        index: true
      t.belongs_to :player,       index: true
      t.integer    :score,        null: false, default: 0
      t.integer    :games_played, null: false, default: 0
      t.integer    :games_won,    null: false, default: 0
      t.timestamps
    end
  end
end

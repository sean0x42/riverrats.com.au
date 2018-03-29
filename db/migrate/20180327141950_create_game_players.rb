class CreateGamePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :games_players do |t|
      t.belongs_to :game
      t.belongs_to :player
      t.integer    :position, null: false, limit: 2
      t.timestamps
    end
  end
end

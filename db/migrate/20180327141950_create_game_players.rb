class CreateGamePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :game_players do |t|
      t.references :game,     null: false
      t.references :player,   null: false
      t.integer    :position, null: false, limit: 2
      t.timestamps
    end
  end
end

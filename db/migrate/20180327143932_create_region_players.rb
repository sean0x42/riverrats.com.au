class CreateRegionPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :region_players do |t|
      t.belongs_to :region,       null: false, index: true
      t.belongs_to :player,       null: false, index: true
      t.integer    :score,        null: false, default: 0
      t.integer    :games_played, null: false, default: 0
      t.integer    :games_won,    null: false, default: 0
      t.timestamps
    end
  end
end

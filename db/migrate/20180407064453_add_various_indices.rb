class AddVariousIndices < ActiveRecord::Migration[5.1]
  def change
    add_index :games_players,   [:game_id, :player_id],   unique: true
    add_index :referees,        [:game_id, :player_id],   unique: true
    add_index :players_venues,  [:player_id, :venue_id],  unique: true
    add_index :players_regions, [:player_id, :region_id], unique: true
    add_index :players_seasons, [:player_id, :season_id], unique: true
  end
end

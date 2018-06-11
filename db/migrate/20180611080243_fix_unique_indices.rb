class FixUniqueIndices < ActiveRecord::Migration[5.2]
  def change
    remove_index :games_players,   [:game_id, :player_id]
    remove_index :referees,        [:game_id, :player_id]
    remove_index :players_venues,  [:player_id, :venue_id]
    remove_index :players_regions, [:player_id, :region_id]
    remove_index :players_seasons, [:player_id, :season_id]
    add_index :games_players,   [:game_id, :player_id]
    add_index :referees,        [:game_id, :player_id]
    add_index :players_venues,  [:player_id, :venue_id]
    add_index :players_regions, [:player_id, :region_id]
    add_index :players_seasons, [:player_id, :season_id]
  end
end

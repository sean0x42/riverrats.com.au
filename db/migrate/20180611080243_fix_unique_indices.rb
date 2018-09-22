# frozen_string_literal: true

class FixUniqueIndices < ActiveRecord::Migration[5.2]
  def change
    remove_index :games_players,   %i[game_id player_id]
    remove_index :referees,        %i[game_id player_id]
    remove_index :players_venues,  %i[player_id venue_id]
    remove_index :players_regions, %i[player_id region_id]
    remove_index :players_seasons, %i[player_id season_id]
    add_index :games_players,   %i[game_id player_id]
    add_index :referees,        %i[game_id player_id]
    add_index :players_venues,  %i[player_id venue_id]
    add_index :players_regions, %i[player_id region_id]
    add_index :players_seasons, %i[player_id season_id]
  end
end

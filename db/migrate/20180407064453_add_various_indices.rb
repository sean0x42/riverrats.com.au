# frozen_string_literal: true

class AddVariousIndices < ActiveRecord::Migration[5.1]
  def change
    add_index :games_players,   %i[game_id player_id],   unique: true
    add_index :referees,        %i[game_id player_id],   unique: true
    add_index :players_venues,  %i[player_id venue_id],  unique: true
    add_index :players_regions, %i[player_id region_id], unique: true
    add_index :players_seasons, %i[player_id season_id], unique: true
  end
end

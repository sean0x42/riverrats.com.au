# frozen_string_literal: true

class AddScoreToGamesPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :games_players, :score, :integer, null: false, default: 0
  end
end

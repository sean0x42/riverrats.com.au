# frozen_string_literal: true

class AddRankingToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players,         :rank, :integer
    add_column :players_seasons, :rank, :integer
    add_column :players_regions, :rank, :integer
    add_column :players_venues,  :rank, :integer
  end
end

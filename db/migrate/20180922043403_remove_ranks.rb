# frozen_string_literal: true

class RemoveRanks < ActiveRecord::Migration[5.2]
  def change
    remove_column :players_regions, :rank, :integer
    remove_column :players_venues, :rank, :integer
  end
end

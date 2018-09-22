# frozen_string_literal: true

class AddSecondPlacesToPlayers < ActiveRecord::Migration[5.2]
  def change
    change_table :players, bulk: true do |t|
      t.integer :second_places, default: 0, null: false
      t.integer :wooden_spoons, default: 0, null: false
    end
  end
end

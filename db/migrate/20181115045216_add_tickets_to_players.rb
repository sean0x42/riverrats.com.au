# frozen_string_literal: true

class AddTicketsToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :tickets, :int, null: false, default: 0
  end
end

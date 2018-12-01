# frozen_string_literal: true

# Adds a nickname field to each player's name
class AddNicknameToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :nickname, :string, null: true, default: nil
  end
end

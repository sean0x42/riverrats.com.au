# frozen_string_literal: true

class AddPasswordChangedToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :password_changed, :boolean, null: false, default: true
  end
end

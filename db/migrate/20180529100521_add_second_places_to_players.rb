class AddSecondPlacesToPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :second_places, :integer, default: 0, null: false
    add_column :players, :wooden_spoons, :integer, default: 0, null: false
  end
end

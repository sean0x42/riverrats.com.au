class AddSoftDeleteToGamesPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :games_players, :soft_delete, :boolean, null: false, default: false
  end
end

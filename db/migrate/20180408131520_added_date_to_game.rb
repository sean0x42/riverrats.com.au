class AddedDateToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :played_on, :date, null: false, default: Date.today
  end
end

class FixDate < ActiveRecord::Migration[5.2]
  def change
    change_column_default :games, :played_on, nil
  end
end

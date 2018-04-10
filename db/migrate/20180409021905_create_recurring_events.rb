class CreateRecurringEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :type,     :string,  null: false
    add_column :events, :period,   :integer, limit: 1, default: 1
    add_column :events, :interval, :integer, limit: 2, default: 1
    add_column :events, :days,     :text
  end
end

class CreateSingleEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :recurring_event, index: true, null: true
    add_column :events, :type, :string, null: false
  end
end

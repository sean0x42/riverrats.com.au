class CreateRecurringEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :recurring_events do |t|
      t.string :title
      t.references :venue,  null: false
      t.datetime :start_at, null: false
      t.text :schedule,     null: false
      t.timestamps
    end
  end
end

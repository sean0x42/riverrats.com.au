# frozen_string_literal: true

class CreateRecurringEvents < ActiveRecord::Migration[5.1]
  def change
    change_table :events, bulk: true do |t|
      t.integer :period,   limit: 1, default: 1
      t.integer :interval, limit: 2, default: 1
      t.text :days
    end
  end
end

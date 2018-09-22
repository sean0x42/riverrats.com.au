# frozen_string_literal: true

class AddNotificationSettings < ActiveRecord::Migration[5.1]
  def change
    change_table :players, bulk: true do |t|
      t.boolean :notify_promotional, null: false, default: true
      t.boolean :notify_events, null: false, default: true
    end
  end
end

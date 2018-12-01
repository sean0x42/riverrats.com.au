# frozen_string_literal: true

class AddReadToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :read, :boolean, default: false, null: false
  end
end

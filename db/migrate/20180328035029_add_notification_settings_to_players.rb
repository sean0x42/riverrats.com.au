class AddNotificationSettingsToPlayers < ActiveRecord::Migration[5.1]
  def change
    add_column :players, :notify_promotional, :boolean, null: false, default: true
    add_column :players, :notify_events,      :boolean, null: false, default: true
  end
end

# frozen_string_literal: true

class AddLevelToAchievements < ActiveRecord::Migration[5.2]
  def change
    add_column :achievements, :level, :integer, null: false, default: 0
  end
end

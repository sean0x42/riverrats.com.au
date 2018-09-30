# frozen_string_literal: true

class CreateAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements do |t|
      t.string :type, null: false
      t.belongs_to :player, null: false, index: true
      t.timestamps
    end
    add_attachment :achievements, :proof
  end
end

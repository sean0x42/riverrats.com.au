# frozen_string_literal: true

class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.references :player, index: true
      t.integer :action
      t.string :description
      t.timestamps
    end
  end
end

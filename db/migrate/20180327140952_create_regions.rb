# frozen_string_literal: true

class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.timestamps
    end

    add_index :regions, :slug, unique: true
  end
end

# frozen_string_literal: true

class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.references :region, null: false
      t.decimal :latitude,  precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :address
      t.string :suburb
      t.integer :state, limit: 1
      t.timestamps
    end

    add_index :venues, :slug, unique: true
  end
end

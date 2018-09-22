# frozen_string_literal: true

class AddFieldsToVenues < ActiveRecord::Migration[5.2]
  def change
    reversible do |change|
      change.up do
        change_table :venues, bulk: true do |t|
          t.decimal :latitude,  precision: 10, scale: 6
          t.decimal :longitude, precision: 10, scale: 6
          t.string :address
          t.string :suburb
          t.integer :state, limit: 1
        end
      end

      change.down do
        change_table :venues, bulk: true do |t|
          t.remove :latitude
          t.remove :longitude
          t.remove :address
          t.remove :suburb
          t.remove :state
        end
      end
    end

    change_table :venues, bulk: true do |t|
      t.string :facebook
      t.string :website
      t.string :phone_number
      t.string :address_line_one
      t.string :address_line_two
      t.string :suburb
      t.integer :post_code
      t.integer :state, default: 1, limit: 1
    end

    add_attachment :venues, :image
  end
end

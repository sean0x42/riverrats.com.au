# frozen_string_literal: true

class AddFieldsToVenues < ActiveRecord::Migration[5.2]
  def change
    change_table :venues, bulk: true do |t|
      t.remove :latitude
      t.remove :longitude
      t.remove :address
      t.remove :suburb
      t.remove :state
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

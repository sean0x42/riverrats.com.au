class AddFieldsToVenues < ActiveRecord::Migration[5.2]
  def change
    remove_column :venues, :latitude
    remove_column :venues, :longitude
    remove_column :venues, :address
    remove_column :venues, :suburb
    remove_column :venues, :state
    add_column :venues, :facebook,         :string
    add_column :venues, :website,          :string
    add_column :venues, :phone_number,     :string
    add_column :venues, :address_line_one, :string
    add_column :venues, :address_line_two, :string
    add_column :venues, :suburb,           :string
    add_column :venues, :post_code,        :integer
    add_column :venues, :state,            :integer, default: 1, limit: 1
    add_attachment :venues, :image
  end
end

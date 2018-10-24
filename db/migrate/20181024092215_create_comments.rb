# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.belongs_to :game, index: true, null: false
      t.belongs_to :player, index: true, null: false
      t.text :body
      t.timestamps
    end
  end
end

# frozen_string_literal: true

class RemoveUniqueFromPlayerEmails < ActiveRecord::Migration[5.2]
  def change
    remove_index :players, :email
    add_index :players, :email
  end
end

# frozen_string_literal: true

class AddIsDeveloperToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :is_developer, :boolean, default: false
  end
end

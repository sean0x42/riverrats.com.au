# frozen_string_literal: true

class RenameIsAdminToAdmin < ActiveRecord::Migration[5.2]
  def change
    rename_column :players, :is_admin, :admin
    rename_column :players, :is_developer, :developer
  end
end

# frozen_string_literal: true

# Changes admin permission groups
class ChangePermissionGroups < ActiveRecord::Migration[5.2]
  def up
    # Add new enum column and migrate existing values
    add_column :players, :group, :integer, default: 0, null: false
    say 'Admin\'s coerced into tournament directors'
    say 'Please reindex players'
    Player.where(admin: true).update(group: :tournament_director)
    Player.where(developer: true).update(group: :developer)

    # Remove old columns
    change_table :players do |t|
      t.remove :admin, :developer
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

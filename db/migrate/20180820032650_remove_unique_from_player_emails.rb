class RemoveUniqueFromPlayerEmails < ActiveRecord::Migration[5.2]
  def change
    # Removes the unique specifier on this index
    remove_index :players, :email
    add_index :players, :email
  end
end

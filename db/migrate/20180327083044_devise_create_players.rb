# frozen_string_literal: true

class DeviseCreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string  :username,     null: false
      t.string  :first_name,   null: false
      t.string  :last_name,    null: false
      t.integer :score,        null: false, default: 0
      t.integer :games_played, null: false, default: 0
      t.integer :games_won,    null: false, default: 0
      t.boolean :is_admin,     null: false, default: false

      ## Database authenticatable
      t.string :email
      t.string :encrypted_password, default: '', null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, null: false, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :players, :username,             unique: true
    add_index :players, :email,                unique: true
    add_index :players, :reset_password_token, unique: true
  end
end

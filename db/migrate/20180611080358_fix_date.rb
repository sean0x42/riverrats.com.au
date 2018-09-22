# frozen_string_literal: true

class FixDate < ActiveRecord::Migration[5.2]
  def change
    change_column_default :games, :played_on, from: Time.zone.today, to: nil
  end
end

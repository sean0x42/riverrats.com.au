class CreateReferees < ActiveRecord::Migration[5.1]
  def change
    create_table :referees do |t|
      t.belongs_to :game,   index: true
      t.belongs_to :player, index: true
      t.timestamps
    end
  end
end

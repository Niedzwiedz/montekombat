class CreateRound < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.belongs_to :tournament, index: true, null: false
      t.integer :round_number
    end
  end
end

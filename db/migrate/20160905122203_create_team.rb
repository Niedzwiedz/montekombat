class CreateTeam < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.belongs_to :tournament, index: true
      t.string :name
    end
  end
end

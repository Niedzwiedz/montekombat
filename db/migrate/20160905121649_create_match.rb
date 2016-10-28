class CreateMatch < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.belongs_to :game, index: true, null: false
      t.belongs_to :team_1, index: true, null: false
      t.belongs_to :team_2, index: true, null: false
      t.belongs_to :winner, index: true
      t.belongs_to :round, index: true
      t.belongs_to :creator, index: true, null: false
      t.integer :points_for_team1, default: 0
      t.integer :points_for_team2, default: 0
      t.datetime :date
      t.integer :match_type, default: 0
      t.integer :status, default: 0
    end
  end
end

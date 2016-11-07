class CreateTournament < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.belongs_to :game, index: true, null: false
      t.belongs_to :creator, index: true, null: false
      t.belongs_to :winner, index: true
      t.string :title, null: false
      t.integer :number_of_teams, null: false
      t.integer :status, default: 0
      t.integer :tournament_type, default: 0
      t.integer :number_of_players_in_team, null: false
      t.text :description
      t.datetime :start_date, null: false
      t.string :tournament_picture
    end
  end
end

class CreateTournamentTeam < ActiveRecord::Migration[5.0]
  def change
    create_table :tournament_teams do |t|
      t.belongs_to :tournament, index: true, null: false
      t.belongs_to :team, index: true, null: false
    end
  end
end

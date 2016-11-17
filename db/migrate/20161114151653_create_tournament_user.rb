class CreateTournamentUser < ActiveRecord::Migration[5.0]
  def change
    create_table :tournament_users do |t|
      t.belongs_to :tournament, index: true, null: false
      t.belongs_to :user, index: true, null: false
    end
    add_index :tournament_users, [:tournament_id, :user_id], unique: true
  end
end

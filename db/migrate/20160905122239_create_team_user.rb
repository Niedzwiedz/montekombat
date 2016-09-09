class CreateTeamUser < ActiveRecord::Migration[5.0]
  def change
    create_table :team_users do |t|
      t.belongs_to :team, index: true, unique: true
      t.belongs_to :user, index: true, unique: true
    end
  end
end

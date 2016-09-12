class CreateTeamUser < ActiveRecord::Migration[5.0]
  def change
    create_table :team_users do |t|
      t.belongs_to :team, index: true
      t.belongs_to :user, index: true
    end
    add_index :team_user [:team, :user], uniqe: true
  end
end

class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user
  validates :team, :user, presence: true
  validate :duplicated_players

  def duplicated_players
    if team.team_users.uniq.size < team.team_users.size
      errors[:team] << "Can't be duplicated players in teams"
    end
  end
end

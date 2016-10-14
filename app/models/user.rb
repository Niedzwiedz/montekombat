class User < ApplicationRecord
  has_many :team_users
  has_many :teams, through: :team_users
  has_many :tournaments
  has_many :matches

  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validates_format_of :email, with: /@/

  validates :username, presence: true, uniqueness: true, length: { minimum: 3,
                                                                   maximum: 25 }
  validates :firstname, presence: true, length: { maximum: 40 }
  validates :lastname, presence: true, length: { maximum: 40 }

  enum account_type: {
    normal: 0,
    admin: 1,
  }

  def tournament_member?(tournament)
    tournament.teams.each do |team|
      return true if team_member?(team)
    end
    false
  end

  def team_member?(team)
    team.users.each do |user_in_team|
      return true if user_in_team.id == id
    end
    false
  end

  private

  def players_in_tournament(tournament_id)
    User.joins(:team).where(teams: { tournament_id: tournament_id })
  end

  def player_distinction_in_tournament
    teams.each do |team|
      players_in_tournament(team.tournament.id)
    end
  end

  def unique_players_in_tournament
    unless players_in_tournament.distinct.length == players_in_tournament.length
      errors[:tournament] << "Two teams in same tournament can't have same player."
    end
  end

  has_secure_password
end

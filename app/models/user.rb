class User < ApplicationRecord
  has_many :team_users
  has_many :teams, through: :team_users
  has_many :tournament_users
  has_many :tournaments, through: :tournament_users

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
    tournament.teams.joins(:users).where(users: { id: id }).any?
  end

  def team_member?(team)
    team.users.where(id: id).any?
  end

  has_secure_password
end

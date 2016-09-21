class User < ApplicationRecord
  has_many :team_users
  has_many :teams, through: :team_users

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

  def member?(tournament)
    Tournament.joins(:teams).each do |tourn|
      return true if tourn == tournament
    end
    false
  end

  has_secure_password
end

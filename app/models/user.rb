class User < ApplicationRecord
  has_many :teams, through: :team_user
  has_many :team_user

  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }
  validates_format_of :email, with: /@/

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :firstname, presence: true, length: { maximum: 40 }
  validates :lastname, presence: true, length: { maximum: 40 }

  enum account_type: {
    normal: 0,
    admin: 1,
  }
  validates :account_type, inclusion: { in: %w(normal admin) }
end

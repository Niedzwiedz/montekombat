class User < ApplicationRecord
  has_many :teams, through: :team_user
  has_many :team_user

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :firstname, presence: true
  validates :lastname, presence: true

  validates_format_of :email, with: /@/
end

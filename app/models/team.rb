class Team < ApplicationRecord
  has_many :matches
  has_many :users, through: :team_user
  has_many :team_user

  validates :name, uniqueness: true, length: { minimum: 3, maximum: 66 }
end

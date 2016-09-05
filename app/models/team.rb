class Team < ApplicationRecord
  has_many :match
  has_many :users, through: :team_user
end

class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user
  validates :team, uniqueness: { scope: :user }
end

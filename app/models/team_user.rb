class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user
  validates :team, uniqueness: { scope: :user }
  validates_presence_of :team, :user
end

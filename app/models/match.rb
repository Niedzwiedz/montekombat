class Match < ApplicationRecord
  belongs_to :team_1, class_name: 'Team'
  belongs_to :team_2, class_name: 'Team'
  belongs_to :game

  validates :points_for_team1, presence: true
  validates :points_for_team2, presence: true
  validates :team_1, presence: true
  validates :team_2, presence: true

end

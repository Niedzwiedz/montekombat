class Match < ApplicationRecord
  belongs_to :team_1, class_name: 'Team'
  belongs_to :team_2, class_name: 'Team'
  belongs_to :game
end

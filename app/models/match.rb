class Match < ApplicationRecord
  belongs_to :team_1, class_name: "Team"
  belongs_to :team_2, class_name: "Team"
  belongs_to :game

  validates :points_for_team1, presence: true
  validates :points_for_team2, presence: true
  validates :team_1, presence: true
  validates :team_2, presence: true
  validate :same_player_cant_be_in_both_teams

  def same_player_cant_be_in_both_teams
    check_teams_for_same_players if !team_1.nil? && !team_2.nil?
  end

  def check_teams_for_same_players
    unless team_1.users & team_2.users == []
      errors[:player] << "Same player can't be a member of both teams"
    end
  end
end

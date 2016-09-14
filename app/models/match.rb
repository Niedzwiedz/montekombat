class Match < ApplicationRecord
  belongs_to :team_1, class_name: "Team"
  belongs_to :team_2, class_name: "Team"
  belongs_to :game

  validates_presence_of :team_1, :team_2, :points_for_team1, :points_for_team2, :match_type, :status
  validate :same_player_cant_be_in_both_teams

  enum match_type: {
    friendly: 0,
    competetive: 1,
  }

  enum status: {
    upcoming: 0,
    in_progress: 1,
    finished: 2,
  }

  private

  # Validate that there aren't same players in both teams
  def same_player_cant_be_in_both_teams
    same_players_check if team_1.present? && team_2.present?
  end

  def same_players_check
    unless team_1.user_ids & team_2.user_ids == []
      errors[:player] << "Same player can't be a member of both teams"
    end
  end
end

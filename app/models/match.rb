class Match < ApplicationRecord
  belongs_to :team_1, class_name: "Team"
  belongs_to :team_2, class_name: "Team"
  belongs_to :creator, class_name: "User"
  belongs_to :game
  belongs_to :round

  validates :team_1, :team_2, :points_for_team1, :points_for_team2, :match_type, :status, presence: true
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

  def player?(user)
    (team_1.user_ids.include? user.id) || (team_2.user_ids.include? user.id)
  end

  def creator?(user)
    creator.id == user.id
  end

  def remove_loser
    if points_for_team1 != points_for_team2
      loser = points_for_team1 > points_for_team2 ? team_2 : team_1
      round.tournament.decrement!(:number_of_teams)
      if last_match_in_round?
        end_tournament
      end
    end
  end

  def last_match_in_round?
    matches_statuses = round.matches.pluck(:status)
    if matches_statuses.include?("upcoming") || matches_statuses.include?("in_progress")
      return false
    end
    true
  end

  def last_match_in_tournament?
    round.tournament.teams.count == 2
  end

  def deathmatch_round_generator
    DeathmatchWorker.perform_async(round.tournament.id)
  end

  private

  def end_tournament
    round.tournament.update_attributes(status: "ended")
  end

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

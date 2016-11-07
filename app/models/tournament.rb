class Tournament < ApplicationRecord
  mount_uploader :tournament_picture, TournamentPictureUploader

  belongs_to :game
  belongs_to :creator, class_name: "User"
  belongs_to :winner, class_name: "Team"
  has_many :teams
  has_many :rounds

  accepts_nested_attributes_for :teams

  validates :title, :start_date, :game, :creator, :number_of_teams, presence: true
  validates :number_of_players_in_team, presence: true
  validate :check_team_number
  validate :check_player_number
  validate :each_team_players_count
  validate :cannot_be_too_many_teams
  validate :unique_players_in_tournament

  enum status: {
    open: 0,
    started: 1,
    ended: 2,
  }

  enum tournament_type: {
    deathmatch: 0,
    league: 1,
  }

  def playing_teams
    current_teams = teams.ids
    rounds.each do |round|
      round.matches.each do |match|
        if match.points_for_team1 > match.points_for_team2 && match.finished?
          current_teams.delete(match.team_2.id)
        else
          current_teams.delete(match.team_1.id)
        end
      end
    end
    current_teams
  end

  def empty_slots
    number_of_slots - player_count
  end

  def player_count
    players_in_tournament.count
  end

  def number_of_slots
    number_of_players_in_team * number_of_teams
  end

  private

  def each_team_players_count
    teams.each { |team| players_count_in_team(team) }
  end

  def players_in_tournament
    User.joins(:teams).where(teams: { tournament_id: id })
  end

  def unique_players_in_tournament
    unless players_in_tournament.distinct.length == players_in_tournament.length
      errors[:tournament] << "Two teams in same tournament can't have same player."
    end
  end

  def players_count_in_team(team)
    team_max_size_check(team) if number_of_players_in_team.present? && team.users.size.present?
  end

  def team_max_size_check(team)
    if team.users.size > number_of_players_in_team
      errors[:tournament] << "Team has too many players."
    end
  end

  def check_team_number
    cannot_be_too_many_teams if numbers_of_teams_and_players_specified
  end

  def check_player_number
    cannot_be_too_many_players if numbers_of_teams_and_players_specified
  end

  def numbers_of_teams_and_players_specified
    number_of_teams.present? && number_of_players_in_team.present?
  end

  # ------------------------------------------------------------------
  # Make sure that there aren't too many players even after update
  def cannot_be_too_many_players
    errors[:tournament] << "There cannot be too many players." if empty_slots < 0
  end

  # ------------------------------------------------------------------
  # Checks if there is correct number of teams
  def cannot_be_too_many_teams
    if teams.size > number_of_teams
      errors[:tournament] << "There cannot be more teams than specified number."
    end
  end
end

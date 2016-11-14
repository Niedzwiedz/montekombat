class Tournament < ApplicationRecord
  mount_uploader :tournament_picture, TournamentPictureUploader

  belongs_to :game
  belongs_to :creator, class_name: "User"
  has_many :teams
  has_many :tournament_users, validate: true
  has_many :users, through: :tournament_users

  accepts_nested_attributes_for :teams

  validates :title, :start_date, :game, :creator, :number_of_teams, :number_of_players_in_team, presence: true
  validate :team_size, if: :numbers_of_teams_and_players_specified
  validate :full_tournament, if: :numbers_of_teams_and_players_specified
  validate :each_team_players_count

  enum status: {
    open: 0,
    started: 1,
    ended: 2,
  }

  enum tournament_type: {
    deathmatch: 0,
    league: 1,
  }

  def empty_slots
    number_of_slots - users.count
  end

  def number_of_slots
    number_of_players_in_team * number_of_teams
  end

  private

  def each_team_players_count
    teams.each { |team| players_count_in_team(team) }
  end

  def players_count_in_team(team)
    team_max_size_check(team) if number_of_players_in_team.present? && team.users.size.present?
  end

  def team_max_size_check(team)
    if team.users.size > number_of_players_in_team
      errors[:tournament] << "Team has too many players."
    end
  end

  def numbers_of_teams_and_players_specified
    number_of_teams.present? && number_of_players_in_team.present?
  end

  # ------------------------------------------------------------------
  # Make sure that there aren't too many players even after update
  def full_tournament
    errors[:tournament] << "There cannot be too many players." if empty_slots < 0
  end

  # ------------------------------------------------------------------
  # Checks if there is correct number of teams
  def team_size
    if teams.size > number_of_teams
      errors[:tournament] << "There cannot be more teams than specified number."
    end
  end
end

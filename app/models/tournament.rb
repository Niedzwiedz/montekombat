class Tournament < ApplicationRecord
  mount_uploader :tournament_picture, TournamentPictureUploader

  belongs_to :game
  belongs_to :creator, class_name: "User"
  has_many :tournament_teams
  has_many :teams, through: :tournament_teams

  validates :title, :game, :creator, :start_date, :number_of_teams, presence: true
  validates :number_of_players_in_team, presence: true
  validate :team_number
  validate :player_number

  enum status: {
    open: 0,
    started: 1,
    ended: 2,
  }

  enum tournament_type: {
    deathmatch: 0,
    league: 1,
  }

  # ------------------------------------------------------------------
  # Tells how many empty slots are left
  def empty_slots
    sum = Team.joins(:users).size
    (number_of_players_in_team * number_of_teams) - sum
  end

  private

  def team_number
    cannot_be_too_many_teams if number_of_teams.present? && number_of_players_in_team.present?
  end

  def player_number
    cannot_be_too_many_players if number_of_teams.present? && number_of_players_in_team.present?
  end

  # ------------------------------------------------------------------
  # Make sure that there are not too many players even after update
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

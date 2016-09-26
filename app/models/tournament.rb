class Tournament < ApplicationRecord
  mount_uploader :tournament_picture, TournamentPictureUploader

  belongs_to :game
  belongs_to :creator, class_name: "User"
  has_many :tournament_teams
  has_many :teams, through: :tournament_teams

  validates :title, :game, :creator, :start_date, :number_of_teams, presence: true
  validates :number_of_players_in_team, presence: true
  validate :check_team_number
  validate :check_player_number

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
    number_of_slots - player_count
  end

  def player_count
    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # Metoda do poprawienia, przykladowe rozwiazania:
    # - team.where
    # - filtrowanie
    # - lub jakis join
    # - tabela TournamentUser
    Team.joins(:users).size
  end

  def number_of_slots
    (number_of_players_in_team * number_of_teams)
  end

  private

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

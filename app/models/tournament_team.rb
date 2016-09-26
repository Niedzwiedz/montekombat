class TournamentTeam < ApplicationRecord
  belongs_to :tournament
  belongs_to :team
  validates :tournament, :team, presence: true

  validate :players_count_in_tournament

  private

  def players_count_in_tournament
    team_max_size_check if tournament.number_of_players_in_team.present? && team.users.size.present?
  end

  def team_max_size_check
    if team.users.size > tournament.number_of_players_in_team
      errors[:tournament] << "Team has too many players."
    end
  end
end

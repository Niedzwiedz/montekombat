class TournamentTeam < ApplicationRecord
  belongs_to :tournament
  belongs_to :team
  validates :tournament, :team, presence: true

  validate :too_many_players

  private

  def too_many_players
    cannot_be_too_many_players if tournament.number_of_players_in_team.present? && team.users.size.present?
  end

  def cannot_be_too_many_players
    if team.users.size > tournament.number_of_players_in_team
      errors[:tournament] << "Team has too many players."
    end
  end
end

class TournamentTeam < ApplicationRecord
  belongs_to :tournament
  belongs_to :team
  validates :tournament, :team, presence: true

  validate :cannot_be_too_many_players

  private

  def cannot_be_too_many_players
    if team.users.size > tournament.number_of_players_in_team
      errors[:tournament] << "#{team} has too many players."
    end
  end
end

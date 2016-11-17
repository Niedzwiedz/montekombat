class TournamentUser < ApplicationRecord
  belongs_to :tournament
  belongs_to :user

  validates :tournament, :user, presence: true
  validate :duplicated_players

  def duplicated_players
    if tournament.tournament_users.uniq.count < tournament.tournament_users.size
      errors[:tournament] << "Can't be duplicated players in tournament"
    end
  end
end

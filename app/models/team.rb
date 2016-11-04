class Team < ApplicationRecord
  has_many :matches
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  has_one :winner
  belongs_to :tournament

  validates :name, uniqueness: true, length: { minimum: 3, maximum: 66 }
  validate :player_cant_be_duplicated_in_team
  validate :cannot_be_too_many_players_in_team
  validate :unique_players_in_tournament
  validates :users, presence: true

  def delete_team_from_matches
    matches_team_1.update_all(team_1_id: 0)
    matches_team_2.update_all(team_2_id: 0)
  end

  def delete_empty_matches
    empty_matches.delete_all
  end

  private

  def player_cant_be_duplicated_in_team
    errors[:player] << "Player can't be duplicated" unless users.distinct.length == users.length
  end

  def cannot_be_too_many_players_in_team
    if tournament.number_of_players_in_team < users.size
      errors[:player] << "Can't be too many players in team"
    end
  end

  def players_in_tournament
    User.joins(:teams).where(teams: { tournament_id: tournament.id })
  end

  def unique_players_in_tournament
    unless players_in_tournament.distinct.length == players_in_tournament.length
      errors[:tournament] << "Two teams in same tournament can't have same player."
    end
  end

  def matches_team_1
    Match.where('team_1_id = ?', id)
  end

  def matches_team_2
    Match.where('team_2_id = ?', id)
  end

  def empty_matches
    Match.where('team_1_id = ? AND team_2_id = ?', 0, 0)
  end
end

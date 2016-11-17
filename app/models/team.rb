class Team < ApplicationRecord
  has_many :matches
  has_many :team_users, dependent: :destroy
  has_many :users, through: :team_users
  belongs_to :tournament

  validates :name, uniqueness: true, length: { minimum: 3, maximum: 66 }
  validate :team_users_count
  validates :team_users, presence: true

  private

  def team_users_count
    if tournament.number_of_players_in_team < users.size
      errors[:player] << "Can't be too many players in team"
    end
  end

  def duplicated_players
    user_ids = team_users.map(&:user_id)
    return if user_ids == user_ids.uniq
    errors[:tournament] << "Can't be duplicated players in tournament"
  end
end

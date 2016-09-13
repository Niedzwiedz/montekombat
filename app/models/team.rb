class Team < ApplicationRecord
  has_many :matches
  has_many :users, through: :team_users
  has_many :team_users

  validates :name, uniqueness: true, length: { minimum: 3, maximum: 66 }
  validate :player_cant_be_duplicated_in_team
  validates_presence_of :users

  private

  def player_cant_be_duplicated_in_team
    errors[:player] << "Player can't be duplicated" unless users.uniq.length == users.length
  end
end

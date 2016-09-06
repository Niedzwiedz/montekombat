class Game < ActiveRecord::Base
  has_many :matchs

  validates :name, uniqueness: true, presence: true
end

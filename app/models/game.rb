class Game < ActiveRecord::Base
  has_many :match

  validates :name, uniqueness: true, presence: true
end

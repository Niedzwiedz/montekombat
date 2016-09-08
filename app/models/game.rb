class Game < ActiveRecord::Base
  has_many :matches

  validates :name, uniqueness: true, presence: true, length: { maximum: 100 }
end

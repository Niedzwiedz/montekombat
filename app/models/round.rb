class Round < ApplicationRecord
  has_many :matches
  belongs_to :tournament

  validates :tournament, :round_number, presence: true
end

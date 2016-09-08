class Game < ActiveRecord::Base
  has_many :matches
  mount_uploader :game_picture, GamePictureUploader

  validates :name, uniqueness: true, presence: true, length: { maximum: 100 }
end

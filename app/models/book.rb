class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :image, presence: true
  validates :genre, presence: true
  
  has_many :favorites, dependent: :destroy
  has_many :reverses_of_likes, through: :favorites, source: :user
  has_many :reviews, dependent: :destroy
  
end

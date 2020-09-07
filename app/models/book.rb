class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
end

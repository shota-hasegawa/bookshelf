class Review < ApplicationRecord
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :evaluation, presence: true
  validates :book_id, presence: true
  belongs_to :user
  belongs_to :book
  
end

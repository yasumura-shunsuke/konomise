class Group < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :user_id, presence: true
  validates :sentence, presence: true, length: { maximum: 100 }
end

class Group < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :user_id, presence: true
  validates :sentence, presence: true, length: { maximum: 100 }
  
  has_many :relationships, :dependent => :destroy
  has_many :group_users, through: :relationships, source: :user
  
  has_many :posts, :dependent => :destroy
  
  has_many :favorites
  has_many :group_retaurants, through: :favorites, source: :restaurant
  
  
  
end

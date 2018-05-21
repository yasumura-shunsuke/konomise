class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 10 },
                   uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :groups
  has_many :relationships
  has_many :user_groups, through: :relationships, source: :group
  
  has_many :posts
  
  has_many :favorites
  has_many :user_restaurants, through: :favorites, source: :restaurant
  
  def join(group)
    self.relationships.find_or_create_by(group_id: group.id)
  end

  def exit(group)
    relationship = self.relationships.find_by(group_id: group.id)
    relationship.destroy if relationship
  end

  def join?(group)
    self.user_groups.include?(group)
  end
  
  def like(group, restaurant)
    self.favorites.find_or_create_by(restaurant_id: restaurant.id, group_id: group.id)
    
  end
  
  def unlike(group, restaurant)
    favorite = self.favorites.find_by(restaurant_id: restaurant.id, group_id: group.id)
    favorite.destroy if favorite
  end

  def like?(group, restaurant)
    self.favorites.find_by(restaurant_id: restaurant.id, group_id: group.id)&.restaurant_id == restaurant.id
  end
  
  
end

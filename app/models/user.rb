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
  
end

class Restaurant < ApplicationRecord
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :area, presence: true, length: { maximum: 10 }
  validates :station, presence: true, length: { maximum: 10 }
  validates :phone_number, presence: true, length: { maximum: 10 }
  
  has_many :favorites
  
  def self.search(param)
    if param.present?
      where(['name LIKE ?', "%#{param}%"])
    end
  end
end

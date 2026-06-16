class Category < ApplicationRecord
  has_many :expenses  # 収支との関連付け
  has_many :products, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end

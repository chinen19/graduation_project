class Category < ApplicationRecord
  has_many :expenses  # 収支との関連付け
  has_many :products, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true

  # 固定カテゴリを取得するスコープを追加
  scope :fixed, -> { where(fixed: true) }
end

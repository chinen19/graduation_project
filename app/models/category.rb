class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # 固定カテゴリを取得するスコープを追加
  scope :fixed, -> { where(fixed: true) }
end
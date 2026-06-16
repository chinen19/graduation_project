class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category  # カテゴリとの関連付け
  
  validates :date, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :category_id, presence: true
end
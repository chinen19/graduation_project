class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category


  validates :name, presence: true
  validates :category_id, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true
  # validates :comment, presence: true
end

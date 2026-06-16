lass Memo < ApplicationRecord
  # validates :comment, presence: true  # 👈 この行を削除またはコメントアウト
  
  # コメントの長さ制限のみ残す場合
  validates :comment, length: { maximum: 50 }, allow_blank: true
end
class User < ApplicationRecord
  authenticates_with_sorcery!
  # Sorceryの認証機能をこのモデルで有効にするための宣言

  # アソシエーション
  has_many :expenses, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :user_name, presence: true, uniqueness: true, length: { maximum: 255 }
  # ユーザー名の存在チェックと重複禁止
  validates :email, presence: true, uniqueness: true
# パスワードのバリデーション
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end

class User < ApplicationRecord
  authenticates_with_sorcery!
  # Sorceryの認証機能をこのモデルで有効にするための宣言

  validates :user_name, presence: true, uniqueness: true
  # ユーザー名の存在チェックと重複禁止
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
end

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  # ユーザー登録フォームを表示
  def new
    @user = User.new
  end

  # ユーザー登録処理
  def create
    @user = User.new(user_params)
    
    if @user.save
      # 保存成功時の処理
      redirect_to login_path, success: 'ユーザー登録が完了しました'
    else
      # 保存失敗時の処理
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  private
  #ストロングパラメーター

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    #params の中から "user"というキーを探す。permitで:user_name, :email, :password, :password_confirmationのみチェック
  end
end

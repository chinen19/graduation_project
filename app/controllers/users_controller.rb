class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'ユーザー登録が完了しました'
    else
      render :new
    end
  end

  private
  #ストロングパラメーター

  def user_params
    params.require(:user).permit(:user_name, :email, :password)
    #params の中から "user"というキーを探す。permitで:user_name, :email, :password, :password_confirmation飲みチェック
  end
end

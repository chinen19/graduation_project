class ApplicationController < ActionController::Base
  # Sorcery の require_login を使用
  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, alert: 'ログインしてください'
  end
end
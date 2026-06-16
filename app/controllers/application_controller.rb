class ApplicationController < ActionController::Base
  before_action :require_login
  helper_method :logged_in?, :current_user
  

  private
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'ログインしてください'
    end
  end

  def not_authenticated
    redirect_to login_path
  end
end

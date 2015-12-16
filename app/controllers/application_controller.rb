class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_login

  helper_method :logged_in?, :current_user

  def logged_in?
    session[:user_id].present?
  end

  def current_user
    @user ||= User.find(session[:user_id])
  end

  private

  def require_login
    redirect_to login_path unless logged_in?
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end
end

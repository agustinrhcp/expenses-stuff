class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :require_login

  def logged_in?
    session[:user_id].present?
  end

  def require_login
    redirect_to login_path unless logged_in?
  end

	private

	def login(user_id)
    session[:user_id] = user_id
	end
end

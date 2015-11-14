class UsersController < ApplicationController
	skip_before_filter :require_login, only: [:new, :create]

	def create
		user_attrs = params[:user].permit(:email, :password, :password_confirmation)
		user = User.create!(user_attrs)

		login(user.id)

		redirect_to expenses_path
	end
end

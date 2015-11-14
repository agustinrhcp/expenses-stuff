class SessionsController < ApplicationController
	skip_before_filter :require_login

	def create
		auth = params[:auth] || {}

		user = User.authenticate(auth[:email], auth[:password])
		login(user.id)

		redirect_to expenses_path
	end

	def destroy
	end
end

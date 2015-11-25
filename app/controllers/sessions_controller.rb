class SessionsController < ApplicationController
  skip_before_filter :require_login

  def create
    auth = params[:auth] || {}
    email = auth[:email]
    password = auth[:password]

    user = User.find_by_email(auth[:email])

    if user && user.authenticates?(auth[:password])
      login(user)
      redirect_to expenses_path
    else
      flash.now[:error] = t('.invalid_credentials')
      render :new
    end
  end

  def destroy
  end
end

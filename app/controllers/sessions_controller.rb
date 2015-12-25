class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new
    @user = User.new
  end

  def create
    user_attrs = params.require(:user).permit(:email, :password)
    @user = User.find_by(email: user_attrs[:email])

    if @user && @user.authenticates?(user_attrs[:password])
      login(@user)
      redirect_to expenses_path
    else
      @user = User.new(email: user_attrs[:email])
      flash.now[:error] = t('.invalid_credentials')
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end

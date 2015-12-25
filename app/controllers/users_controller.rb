class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user_attrs = params.require(:user).permit(:email, :password, :password_confirmation)
    @user = User.create(user_attrs)

    if @user.save
      login(@user)
      redirect_to expenses_path
    else
      flash.now[:error] = @user.errors
      render :new
    end
  end
end

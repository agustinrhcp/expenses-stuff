class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def create
    user_attrs = params[:user].permit(:email, :password, :password_confirmation)
    user = User.create!(user_attrs)

    login(user)

    redirect_to expenses_path
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:error] = e.record.errors.full_messages

    render :new
  end
end

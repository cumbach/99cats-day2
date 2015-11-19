class UsersController < ApplicationController
  before_action :check_if_user_signed_in!

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end

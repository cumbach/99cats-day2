class SessionsController < ApplicationController
  before_action :check_if_user_signed_in!, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(*session_params.values)
    if @user.nil?
      render :new
    else
      login_user!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.reset_session_token! unless current_user.nil?
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:user_name, :password)
  end

end

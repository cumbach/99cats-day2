class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    @current_user = user
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def check_if_user_signed_in!
    redirect_to cats_url unless current_user.nil?
  end
end

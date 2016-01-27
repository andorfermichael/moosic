class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # Indicates whether a user is logged in or not
  def current_user
    @current_user = nil
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
  end

  def check_login_state
    redirect_to(root_path, flash: :error) unless session[:user_id]
  end

  helper_method :current_user
end

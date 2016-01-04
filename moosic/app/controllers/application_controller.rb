class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # Indicates whether a user is logged in or not
  def current_user
    @current_user = nil
    if session[:user_id]
      @current_user ||= User.where(id: session[:user_id]).first
      @current_user.count_playlists = User.find(session[:user_id]).playlists.size
      @current_user
    end
  end

  def check_login_state
    if !session[:user_id]
      redirect_to(root_path, :flash => :error)
    end
  end

  helper_method :current_user
end

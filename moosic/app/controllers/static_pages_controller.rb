class StaticPagesController < ApplicationController
  before_action :check_login_state

  def search
    if params[:search]
      @users_filtered = User.search(params[:search]).order("created_at DESC")
      @playlists_filtered = Playlist.search(params[:search]).order("created_at DESC")
    else
      @users_filtered = User.all.order("created_at DESC")
      @playlists_filtered = Playlist.all.order("created_at DESC")
    end
  end

  def user_filter
    respond_to do |format|
      format.js { render 'user_filter.js.erb' }
    end
  end

  def playlist_filter
    respond_to do |format|
      format.js { render 'playlist_filter.js.erb' }
    end
  end

end

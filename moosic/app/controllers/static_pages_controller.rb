class StaticPagesController < ApplicationController
  before_action :check_login_state

  def search
    if params[:search]
      session[:users_filtered] = User.search(params[:search]).order('created_at DESC')
      session[:playlists_filtered] = Playlist.search(params[:search]).order('created_at DESC')
    else
      session[:users_filtered] = User.all.order('created_at DESC')
      session[:playlists_filtered] = Playlist.all.order('created_at DESC')
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

  def add_to_playlist
    s = Song.create(:titel => params[:title], :source => params[:source], :thumbnail_url => params[:thumbnail_url], :song_url => params[:song_url], :host => params[:host], :year => DateTime.now)
    pos = Track.where(playlist_id = params[:playlist_id]).count + 1
    Track.create(:position => pos, :playlist_id => params[:playlist_id], :song_id => s.id)
    redirect_to user_path(session[:user_id])
  end
end

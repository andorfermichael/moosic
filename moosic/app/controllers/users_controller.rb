class UsersController < ApplicationController
  before_action :check_login_state, only: [:show, :edit]
  before_filter :catch_cancel, :update => [:create, :update, :destroy]

  # GET /users
  # GET /users.json
  # Index is default view
  def index
  end

  def show
    # Get all playlists from current user
    @playlists = Playlist.where(user_id: session[:user_id]).all

    # For each playlist store the image url of the first song of the playlist plus the count of songs
    # as an additional information
    @playlists.each do |playlist|
      track = Track.where('playlist_id = ? AND position = ?', playlist.id, 1).first
      if track != nil
        song = Song.find(track.song_id)
        playlist.image_url = song.thumbnail_url
        playlist.count_songs = Playlist.find(playlist.id).songs.size
        true
      else
        playlist.image_url = 'https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150'
        playlist.count_songs = 0
      end
    end
  end

  # Create new user object when rendering new user view
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  # Stores user in database
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(root_path, :flash => :success)
    else
      render 'new'
    end
  end

  # Sets user to current user when rendering edit user view
  def edit
    @user = current_user
  end

  # Updates information of user
  def update
    @user = User.find(session[:user_id])
    if @user.update_attributes(user_params)
      redirect_to(@user, :flash => :success)
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Called when cancel button is pressed
  def catch_cancel
    redirect_to user_path(current_user) if params[:commit] == 'Cancel'
  end
end

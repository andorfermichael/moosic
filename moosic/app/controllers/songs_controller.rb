class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    # Single track
    if params[:singletrack] === 'true'
      # Create a new song with needed attributes from url parameters
      song = Song.new
      song.song_url = params[:songurl]
      song.host = params[:songhost]

      # Make song available in javascript
      gon.current_song = song
      gon.single_track = params[:singletrack]
    else # Playlist
      # Get playlist according to url parameter
      @playlist = Playlist.find(params[:playlist])

      # Get all tracks of that playlist ascending ordered by their position
      tracks = Track.where('playlist_id = ?', params[:playlist]).order(position: :asc).all

      # Get all songs of that playlist
      @songs = []
      tracks.each do |track|
        song = Song.where('id = ?', track.song_id).first
        @songs << song if song
      end

      # Make playlists, songs, count of songs and startposition available in javascript
      gon.current_playlist = @playlist
      gon.current_playlist_songs = @songs
      gon.current_playlist_count_songs = Playlist.find(params[:playlist]).songs.size
      gon.current_position = params[:startposition]
      gon.single_track = params[:singletrack]
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:titel, :source, :thumbnail_url, :song_url, :host, :year)
    end
end

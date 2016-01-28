class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Track successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_track
    @track = Track.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def track_params
    params.require(:track).permit(:position, :playlist_id, :song_id)
  end
end

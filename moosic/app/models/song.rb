class Song < ActiveRecord::Base
  has_many :tracks, dependent: :destroy
  has_many :playlists, :through => :tracks
end

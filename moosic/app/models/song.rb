class Song < ActiveRecord::Base
  has_many :tracks
  has_many :playlists, :through => :tracks
end

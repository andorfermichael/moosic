class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :tracks
  has_many :songs, :through => :tracks

  attr_accessor :image_url
  attr_accessor :count_songs
end

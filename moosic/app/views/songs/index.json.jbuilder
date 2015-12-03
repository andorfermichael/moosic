json.array!(@songs) do |song|
  json.extract! song, :id, :titel, :source, :thumbnail_url, :song_url, :host, :year
  json.url song_url(song, format: :json)
end

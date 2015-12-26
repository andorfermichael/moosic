# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
  {name: "MichaelMustermann", email: "michael.diesunddas@yahoo.de", location: "Salzburg", image_url: "https://upload.wikimedia.org/wikipedia/en/b/b1/Portrait_placeholder.png", password: "secret", },
  {name: "ProfiPeter", email: "profi.peter@profi.com", location: "Wien", image_url: "https://upload.wikimedia.org/wikipedia/en/b/b1/Portrait_placeholder.png", password: "anonymous",},
  {name: "NilpferdNils", email: "nilpferd.nils@nilpferd.com", location: "München", image_url: "https://upload.wikimedia.org/wikipedia/en/b/b1/Portrait_placeholder.png", password: "amazonas"}
])


Song.create([
  {titel: "Radioactive", source: "ImagineDragonsVEVO", thumbnail_url: "https://i.ytimg.com/vi/ktvTqknDobU/mqdefault.jpg", song_url: "ktvTqknDobU", host: "youtube", year: DateTime.new(2015, 9, 1,)},
  {titel: "WILD - Back To You", source: "MrSuicideSheep", thumbnail_url: "https://i.ytimg.com/vi/HtcWvsiQkZE/mqdefault.jpg", song_url: "HtcWvsiQkZE", host: "youtube", year: DateTime.new(2015, 12, 4)}
])


Playlist.create([
  {name: "Chillout", user_id: 1},
  {name: "LoungeMusic", user_id: 1},
  {name: "Motivational", user_id: 3},
  {name: "EDM", user_id: 1},
  {name: "Progressive House", user_id: 1}
])


Track.create([
  {position: 1, playlist_id: 1, song_id: 1},
  {position: 2, playlist_id: 1, song_id: 2},
  {position: 1, playlist_id: 4, song_id: 1},
  {position: 1, playlist_id: 2, song_id: 1}
])
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([
  {username: "MusterMax", email: "muster.max@muster.com", password: "secret", picture_url: "profile.com"},
  {username: "ProfiPeter", email: "profi.peter@profi.com", password: "anonymous", picture_url: "profile.com"},
  {username: "NilpferdNils", email: "nilpferd.nils@nilpferd.com", password: "amazonas"}
])


Song.create([
  {titel: "Radioactive", source: "ImagineDragonsVEVO", thumbnail_url: "https://i.ytimg.com/vi/ktvTqknDobU/mqdefault.jpg", song_url: "ktvTqknDobU", host: "youtube", year: DateTime.new(2015, 9, 1,)},
  {titel: "WILD - Back To You", source: "MrSuicideSheep", thumbnail_url: "https://i.ytimg.com/vi/HtcWvsiQkZE/mqdefault.jpg", song_url: "HtcWvsiQkZE", host: "youtube", year: DateTime.new(2015, 12, 4)}
])


Playlist.create([
  {name: "Chillout", user_id: 1},
  {name: "LoungeMusic", user_id: 1},
  {name: "Motivational", user_id: 3}
])


Track.create([
  {position: 1, playlist_id: 1, song_id: 1},
  {position: 2, playlist_id: 1, song_id: 2},
  {position: 1, playlist_id: 2, song_id: 1}
])
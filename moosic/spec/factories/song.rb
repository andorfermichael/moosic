FactoryGirl.define do
  factory :song do
    titel "Radioactive"
    source "ImagineDragonsVEVO"
    thumbnail_url "https://i.ytimg.com/vi/ktvTqknDobU/mqdefault.jpg"
    song_url "ktvTqknDobU"
    host "youtube"
    year DateTime.new(2015, 9, 1,)
  end
end

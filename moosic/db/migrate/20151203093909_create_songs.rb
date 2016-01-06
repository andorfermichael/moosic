class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :titel
      t.string :source
      t.string :thumbnail_url
      t.string :song_url
      t.string :host
      t.date :year

      t.timestamps null: false
    end
  end
end

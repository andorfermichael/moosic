class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :position
      t.references :playlist, index: true, foreign_key: true
      t.references :song, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

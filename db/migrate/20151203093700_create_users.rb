class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :email
      t.string :location
      t.string :image_url
      t.string :url
      t.string :password_digest

      t.timestamps null: false
    end
    add_index :users, :uid
  end
end

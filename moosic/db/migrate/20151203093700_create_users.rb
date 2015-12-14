class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :name
      t.string :email
      t.string :location
      t.string :image_url
      t.string :url
      t.string :provider, null: false
      t.string :password_digest

      t.timestamps null: false
    end
    add_index :users, :provider
    add_index :users, :uid
    add_index :users, [:provider, :uid], unique: true
  end
end

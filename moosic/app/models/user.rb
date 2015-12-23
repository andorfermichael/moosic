class User < ActiveRecord::Base
  has_secure_password
  has_many :playlists
  has_many :authentications

  validates_confirmation_of :password, :on => :save
  validates :email, uniqueness: true, :on => :save
  validates :email, :email_format => { :message => 'Email-Address has no valid format' }, :on => :save
  validates :name, :email, :password, :password_confirmation, presence: true, :on => :save
  validates :name, length: { in: 4..30 }, :on => :save
  validates :password, length: { in: 9..20 }, :on => :save

  attr_accessor :count_playlists

  # Find and returns existing user
  # or creates and returns a new user
  def self.find_or_create_with_omniauth(auth)
    # Look for an existing authorization
    # provider + uid uniquely identify a user
    a = Authentication.find_or_create_by(
        provider: auth['provider'],
        uid:      auth['uid']
    )

    # Update secret and token which expire from time to time
    a.update( secret: auth['credentials']['secret'],
              token:  auth['credentials']['token']  )
    a.save!

    # Create user if it doesn't exist
    if a.user.nil?
      u = create! do |user|
        user.uid = auth['uid']
        user.name = auth['info']['name']
        user.email = auth['info']['email']
        user.location = auth['info']['location']
        user.image_url = auth['info']['image']
        password = auth['credentials']['token']
        user.password = password[0..5] # Satisfy not null constraint of password digest
      end

      # Store user
      a.user = u
      a.save!(:validate => false) # No validations for social login
    end
    return a.user
  end # def self.find_or_create_with_omniauth(auth)
end

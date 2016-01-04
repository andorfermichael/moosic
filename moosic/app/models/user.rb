class User < ActiveRecord::Base
  has_secure_password
  has_many :playlists
  has_many :authentications

  validates_confirmation_of :password
  validates :email, uniqueness: true
  validates :email, :email_format => { :message => 'has no valid format' }
  validates :name, :email, :password, :password_confirmation, presence: true
  validates :password, :format => {:with => /\A(?=.*[a-z]).+\z/, message: 'must contain at least 1 lowercase character'}
  validates :password, :format => {:with => /\A(?=.*[A-Z]).+\z/, message: 'must contain at least 1 uppercase character'}
  validates :password, :format => {:with => /\A(?=.*[\W]).+\z/, message: 'must contain at least 1 special character'}
  validates :password, :format => {:with => /\A(?=.*\d).+\z/, message: 'must contain at least 1 digit'}
  validates :name, length: { in: 4..30 }
  validates :password, length: { in: 9..20 }

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
      user = User.new
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.email = auth['info']['email']
      user.location = auth['info']['location']
      user.image_url = auth['info']['image']
      user.save(:validate => false)

      # Store user
      a.user = user
      a.save!
    end
    return a.user
  end # def self.find_or_create_with_omniauth(auth)
end

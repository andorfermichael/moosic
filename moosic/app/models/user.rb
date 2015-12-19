class User < ActiveRecord::Base
  has_secure_password
  has_many :playlists
  has_many :authentications

  validates_confirmation_of :password

  def self.find_or_create_with_omniauth(auth)
    # look for an existing authorisation
    # provider + uid uniquely identify a user
    a = Authentication.find_or_create_by(
        provider: auth['provider'],
        uid:      auth['uid']
    )

    # save other info you want to remember:
    a.update( secret: auth['credentials']['secret'],
              token:  auth['credentials']['token']  )
    a.save!

    if a.user.nil?
      # all new user
      u = create! do |user|
        user.uid = auth['uid']
        user.name = auth['info']['name']
        user.email = auth['info']['email']
        user.location = auth['info']['location']
        user.image_url = auth['info']['image']
        user.password = auth['credentials']['secret']
        #user.url = auth['info']['urls'][user.provider.capitalize]
      end

      a.user = u
      a.save!
    end
    a.user
  end # def self.find_or_create_with_omniauth(auth)
end

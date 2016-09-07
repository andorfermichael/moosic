Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_KEY"], ENV["FACEBOOK_SECRET"], scope: 'public_profile', info_fields: 'id, name, email, link', image_size: {width: 512, height: 512}
  provider :twitter, ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"], image_size: 'bigger'
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"], scope: 'profile', image_aspect_ratio: 'square', image_size: 512, access_type: 'online', name: 'google'
  provider :soundcloud, ENV["SOUNDCLOUD_CLIENT_ID"], ENV["SOUNDCLOUD_SECRET"], image_size: {width: 512, height: 512}
end

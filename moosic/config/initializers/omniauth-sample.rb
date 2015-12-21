Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 'FACEBOOK_KEY', 'FACEBOOK_SECRET', scope: 'public_profile', info_fields: 'id,name,link'
  provider :twitter, 'TWITTER_KEY', 'TWITTER_SECRET'
  provider :google_oauth2, 'GOOGLE_CLIENT_ID', 'GOOGLE_SECRET', scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
  provider :soundcloud, 'SOUNDCLOUD_CLIENT_ID', 'SOUNDCLOUD_SECRET'
end
Rails.application.routes.draw do
  root to: 'authentication#index'

  # Login and Sign-up routes
  post '/signup', to: 'users#new'
  get '/auth/:provider/callback', to: 'sessions#create_social'
  post '/authentication', to: 'sessions#create_conventional'
  delete '/logout', to: 'sessions#destroy'

  # Search route
  post 'search', to: 'static_pages#search'

  # Imprint route
  post 'imprint', to: 'static_pages#imprint'

  # Search partial routes
  post 'filter_user', to: 'static_pages#user_filter'
  post 'filter_playlist', to: 'static_pages#playlist_filter'

  # Add Song to Playlist route
  post 'add_to_playlist', to: 'static_pages#add_to_playlist'

  resources :users
  resources :playlists
  resources :songs
  resources :tracks

end

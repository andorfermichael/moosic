Rails.application.routes.draw do
  root to: 'authentication#index'

  # Login and Sign-up routes
  get '/signup', to: 'users#new'
  get '/auth/:provider/callback', to: 'sessions#create_social'
  post '/authentication', to: 'sessions#create_conventional'
  delete '/logout', to: 'sessions#destroy'

  # Search route
  get 'search', to: 'static_pages#search'

  # Imprint route
  get 'imprint', to: 'static_pages#imprint'

  # Search partial routes
  get 'filter_user', to: 'static_pages#user_filter'
  get 'filter_playlist', to: 'static_pages#playlist_filter'

  # Add Song to Playlist route
  get 'add_to_playlist', to: 'static_pages#add_to_playlist'

  resources :users
  resources :playlists
  resources :songs
  resources :tracks

end

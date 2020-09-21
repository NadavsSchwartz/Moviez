Rails.application.routes.draw do
  root to: 'movies#index'

  get '/login', to: 'sessions#new', as: 'signin'
  post '/login', to: 'sessions#create'

  get '/auth/google_oauth2/callback', to: 'sessions#google_auth'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create', as: 'users'

  delete '/signout', to: 'sessions#destroy'
  get 'movies/search', to: 'movies#search', as: 'movie_search'

  get 'movies', to: 'movies#index'

  get 'movies/:id', to: 'movies#find'
  post 'movies/:id', to: 'movies#show', as: 'movie'

  get '/reviews/latest', to: 'reviews#latest', as: 'latest_reviews'

  resources :users, except: [:new]
  resources :movies do
    resources :reviews
    resources :users do
      resources :reviews, only: [:index]
    end
  end

end

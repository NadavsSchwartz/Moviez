Rails.application.routes.draw do
  resources :reviews
  root to: 'movies#index'

  get '/login', to: 'sessions#new', as: 'signin'
  post '/login', to: 'sessions#create'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create', as: 'users'
  # resources :profiles

  get 'movies/search', to: 'movies#search', as: 'movie_search'
  post 'movies/:id', to: 'movies#show', as: 'movie'
  get 'movies/:id', to: 'movies#find'

  resources :users, except: [:new]
    #resources :movies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

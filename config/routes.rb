Rails.application.routes.draw do
    root to: 'movies#search'

    get '/login', to: 'sessions#new', as: 'signin'
    post '/login', to: 'sessions#create'

    get '/signup', to: 'users#new'
    post '/signup', to: 'users#create', as: 'users'

  delete '/signout', to: 'sessions#destroy'
    get 'movies/search', to: 'movies#search', as: 'movie_search'

    get 'movies', to: 'movies#index'

    get 'movies/:id', to: 'movies#find'
    post 'movies/:id', to: 'movies#show', as: 'movie'

    resources :users, except: [:new]
    resources :movies do
    resources :reviews
    end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

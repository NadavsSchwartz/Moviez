Rails.application.routes.draw do
  root to: 'movies#index'

  get '/login', to: 'sessions#new', as: 'signin'
  post '/login', to: 'sessions#create'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create', as: 'users'
  # resources :profiles
  resources :users, except: [:new]
   resources :movies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

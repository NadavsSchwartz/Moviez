Rails.application.routes.draw do
  root to: 'movies#index'
  get '/login', to: 'sessions#new', as: 'signin'
  get '/signup', to: 'users#new'
  post '/login', to: 'sessions#create'
  # resources :profiles
  resources :users, except: [:new]
  # resources :movies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

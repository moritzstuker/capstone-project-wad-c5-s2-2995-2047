Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :projects
  resources :users

  namespace :dashboard do
    resources :account
  end

  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'

  get  '/signup', to: 'users#new'

  get  '/dashboard', to: 'dashboard#index'
end

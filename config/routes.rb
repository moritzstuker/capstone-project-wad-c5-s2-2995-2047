Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :projects
  resources :users
  resources :account
  resources :contacts
  resources :dashboard

  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'

  get  '/signup', to: 'users#new'
end

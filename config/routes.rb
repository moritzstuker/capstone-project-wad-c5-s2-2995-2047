Rails.application.routes.draw do
  root to: 'home#index'

  resources :contacts
  resources :users

  get    '/signup', to: 'users#new'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get    '/dashboard', to: 'dashboard#show'
  get    '/dashboard/edit'

  get    '/account', to: 'account#show'
  get    '/account/edit'
end

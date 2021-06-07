Rails.application.routes.draw do
  root to: 'home#index'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get  '/signup', to: 'users#new'

  get   '/account', to: 'account#edit'
  patch '/account', to: 'account#update'

  resources :activities
  resources :contacts
  resources :deadlines
  resources :home
  resources :projects
  resources :settings
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"

  # Users routes
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy]

  resources :timesheet

  # Session routes
  get  '/login',  to: 'sessions#login'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'

end

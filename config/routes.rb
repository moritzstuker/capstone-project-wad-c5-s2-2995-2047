Rails.application.routes.draw do
  root to: 'home#index'

  resources :contact
  resources :project
  resources :user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

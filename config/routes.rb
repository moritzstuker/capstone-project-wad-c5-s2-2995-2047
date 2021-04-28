Rails.application.routes.draw do
  root to: 'home#index'

  resources :activities
  resources :contacts
  resources :deadlines
  resources :projects
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

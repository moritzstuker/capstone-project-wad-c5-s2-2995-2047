Rails.application.routes.draw do
  root to: 'home#index'

  get '/grid', to: 'home#grid'
  get '/forms', to: 'home#forms'
  get '/styleguide', to: 'home#styleguide'

  resources :activities
  resources :contacts
  resources :deadlines
  resources :home
  resources :projects
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

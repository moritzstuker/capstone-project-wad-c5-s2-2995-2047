Rails.application.routes.draw do
  root to: 'home#index'

  get '/search', to: 'search#redirect'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get    '/signup', to: 'users#new'

  get    '/dashboard', to: 'dashboard#index'

  get    '/account', to: 'account#edit'

  get    '/contacts/import',  to: 'contacts#import'

  resources :contacts
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :projects do
    resources :activities, only: [:create, :destroy]
  end

  resources :deadlines, only: [:index, :create, :new, :edit, :update, :destroy, :complete] do
    member do
      patch :complete
    end
  end
end

# Uncomment to add locale to url params
# scope '/:locale' do
#   root to: 'home#index'
#   # insert here all but the first two rules
# end

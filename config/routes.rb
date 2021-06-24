Rails.application.routes.draw do
  root to: 'home#index'

  get '/search', to: 'search#redirect'

  scope '/:locale' do
    root to: 'home#index'

    get    '/login',  to: 'sessions#new'
    post   '/login',  to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    get    '/signup', to: 'users#new'

    get    '/dashboard', to: 'dashboard#index'

    get    '/account', to: 'account#edit'
    patch  '/account', to: 'account#update'

    get    '/contacts/import',  to: 'contacts#import'

    resources :contacts
    resources :deadlines
    resources :project_categories
    resources :sessions, only: [:new, :create, :destroy]
    resources :users

    resources :projects do
      resources :activities
    end
  end
end

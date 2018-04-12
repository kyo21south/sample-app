Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/login', to:  'sessions#new'
  post '/login', to:  'sessions#create'
  delete '/logout', to:  'sessions#destroy'
  post '/users', to: 'users#search'
  resources :users do
    member do
      get :following, :followers, :favorites
    end
  end
  resources :account_activations, only:[:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts, only:[:create, :destroy] do
    member do
      get :favorer
    end
  end
  resources :relationships, only:[:create, :destroy]
  resources :favorites, only:[:create, :destroy]
end

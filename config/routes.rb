Rails.application.routes.draw do
  
  root to: 'toppages#index'
  
  get 'ranking', to: 'rankings#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :books, only: [:show, :edit, :update, :new, :create, :destroy] 
  resources :reviews, only: [:index, :create]
  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  
end

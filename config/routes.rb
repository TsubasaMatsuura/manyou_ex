Rails.application.routes.draw do
   namespace :admin do
    resources :users
  end
  
  
  root to: 'sessions#new'
  
  resources :sessions, only: [:new, :create, :destroy]

  resources :tasks
  resources :users, only: [:new, :create, :show]
end

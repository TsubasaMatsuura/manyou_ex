Rails.application.routes.draw do
  get 'sessions/new'
   namespace :admin do
    resources :users
  end
  resources :tasks
  root to: 'tasks#index'
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"


  root 'posts#index'

  devise_for :users
  # get 'profile', to: 'users#show', as: 'profile'

  resources :users, only: [:show] do
    collection do
      get :search  # Search for users by username
    end
  end

  resources :posts do
    resources :comments
  end

  resources :follows, only: [:create, :destroy] do
    collection do
      get :followers  # List followers
      get :following  # List following users
      get :pending_requests  # List pending follow requests
    end

    member do
      patch :accept  # Accept a follow request
    end
  end

  resources :chats, only: [:create, :update, :destroy]
  get 'conversation/:user_id', to: 'chats#conversation', as: :conversation
  get 'recent_chats', to: 'chats#recent_chats', as: :recent_chats

  resources :notifications, only: [:index]
end

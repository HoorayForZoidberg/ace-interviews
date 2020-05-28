Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:index, :show] do
    resources :meetings, only: [:create]
  end

  resources :meetings, only: [:index, :show, :edit, :update, :destroy] do
    member do
      get :chat
    end
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: :index
  resources :live_chats, only: :create
end

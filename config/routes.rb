Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:index, :show] do
<<<<<<< HEAD
    resources :meetings, only: [:new, :create]
=======

    resources :meetings, only: [:create]
>>>>>>> 5d801a7002cb0e2d46d75075af0823966895c7f8
  end

  resources :meetings, only: [:index, :show, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: :index
  resources :live_chats, only: :create
end

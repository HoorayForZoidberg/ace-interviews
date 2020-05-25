Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users, only: [:index, :show, :update, :edit, :destroy] do

    resources :meetings, only: [:new, :create]
  end
  resources :meetings, only: [:index, :show, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:index]
end

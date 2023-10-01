Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :orders, only: [:index,:create]
    resources :favorites, only: [:create, :destroy]
  end
  resources :users do
    resources :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end
end

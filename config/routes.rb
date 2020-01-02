Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: :show
end

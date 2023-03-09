Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "home/about" => "home#about", as: "about"
  
  resources :books, only: [:new, :index, :show, :destroy]
  resources :users, only: [:show, :edit]
end

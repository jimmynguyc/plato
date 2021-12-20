Rails.application.routes.draw do
  devise_for :users

  resources :boards
  root 'home#index'
end

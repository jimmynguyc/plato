Rails.application.routes.draw do
  resources :cards
  resources :lanes
  devise_for :users

  resources :boards do
    resources :lanes do
      resources :cards do
        resources :tasks
      end
    end
  end

  root 'home#index'
end

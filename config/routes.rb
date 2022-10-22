Rails.application.routes.draw do
  resources :items, only: [:index, :show]
    
  resources :users, only: [:show, :index] do
    resources :items, only: [:index, :show, :create]
  end

end

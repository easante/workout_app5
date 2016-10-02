Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "dashboards#index"
  
  resources :users do
    resources :exercises
  end
  
  resources :dashboards, only: [:index] do
    collection do
      post :search, to: 'dashboards#search'
    end
  end
  
  resources :friendships, only: [:show, :create, :destroy]
  
end

Rails.application.routes.draw do


  devise_for :users
  get 'welcome/index'
  root to: 'welcome#index'

  resources :wikis
  resources :charges, only: [:new, :create]

  resources :users do 
    member do 
      post :downgrade
    end
  end
  
end

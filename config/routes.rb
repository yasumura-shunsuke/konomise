Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    member do
      get :user_groups
      get :group_users
      get :user_restaurants
    end
  end
  resources :groups do
    member do
      get :group_retaurants
      get :restaurant_search
    end
    resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy]
  #resources :favorites, only: [:create, :destroy]
end

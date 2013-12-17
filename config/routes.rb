Milk::Application.routes.draw do

  devise_for :users

  authenticated :user do
    root :to => "milkruns#index"
  end
  root :to => "milkruns#index"


  resources :users

  resources :buyers do
    resources :payments
    resources :notes
    member do
      get :notes
      get :payments
      get :activate
      get :deactivate
    end
  	collection do
  		get :active
  		get :inactive
  	end
  end

  resources :orders
  resources :payments
  resources :notes

  resources :milkruns do
    resources :orders
    collection do
      get :duplicate
    end
    member do
      get :p_archive
      get :p_pickup
      get :orders
    end
  end

  match '/milkruns', to: "milkruns#index"


end
Milk::Application.routes.draw do

  devise_for :users

  authenticated :user do
    root :to => "milkruns#index"
  end
  root :to => "milkruns#index"


  resources :users

  resources :buyers do
    resources :payments
    member do
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

  resources :milkruns do
    resources :orders
    member do
      get :orders
    end
  end

  match '/milkruns', to: "milkruns#index"


end
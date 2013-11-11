Milk::Application.routes.draw do

  authenticated :user do
  root :to => "milkruns#index"
  end
  root :to => "milkruns#index"
  devise_for :users

  resources :users

  resources :buyers do
  	collection do
  		get :active
  		get :inactive
  	end
  end

	resources :accounts
  resources :orders
  resources :payments
  resources :milkruns


end
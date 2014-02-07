Milk::Application.routes.draw do

  devise_for :users

  authenticated :user do
    root :to => "cycles#home"
  end
  root :to => "cycles#home"


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
    member do
      get :activate
      get :deactivate
      get :p_archive
      get :p_pickup
      get :instructions
      get :orders
    end
    collection do
      post 'sort'
      get :active
      get :inactive
    end
  end

  resources :cycles do
    resources :milkruns
    member do
      get :milkruns
    end
  end

end
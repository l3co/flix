Rails.application.routes.draw do
  root "movies#index"
  resources :movies do
    resources :reviews
  end
  resource :session, only: [:new, :create, :destroy]
  resources :users
  get "signin", to: "sessions#new"
  get "signup", to: "users#new"
  delete "signout", to: "sessions#destroy"
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # custom route
  # get "/" , to: "rails#index"
  # get "/user/:id", to: "rails#show"
  resources :users, only:[:index, :show, :create, :update,  :destroy]
end

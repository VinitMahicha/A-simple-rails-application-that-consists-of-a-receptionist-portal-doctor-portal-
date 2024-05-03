Rails.application.routes.draw do
  devise_for :users
  resources :patients
  root "home#index"
  get '/about', to: 'home#about'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

# config/routes.rb
Rails.application.routes.draw do
  post '/register', to: 'users#create'
  post '/login', to: 'users#login'
  resources :blogs
end

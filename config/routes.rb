Rails.application.routes.draw do
  resources :auth, only: [:create]
 post '/log_in', to: 'auth#create'
 post '/register', to:'users#create'
 get '/register', to: 'users#new'
 get '/users', to: 'users#index'
end

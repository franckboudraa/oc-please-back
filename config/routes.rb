Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  get '/users/current', to: 'users#current'
  post '/requests/within', to: 'requests#within'
  resources :users do
    resources :requests
  end
  resources :requests
end

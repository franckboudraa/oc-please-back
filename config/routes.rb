Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/authenticate', to: 'authentication#authenticate'
  get '/users/current', to: 'users#current'
  get '/me/proposals', to: 'volunteers#proposals'
  post '/requests/within', to: 'requests#within'
  get '/homestats', to: 'application#stats'
  resources :users do
    resources :requests
  end
  resources :requests do
    resources :volunteers
  end

  resources :volunteers do
    resources :messages
  end

  resources :messages
end

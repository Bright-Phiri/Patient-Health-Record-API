Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
      resources :patients do
        resources :vital_signs, only: [:create, :show]
      end
      resources :users
      post '/login', action: :login, controller: 'users'
      get '/statistics', action: :statistics, controller: 'patients'
    end
  end
end

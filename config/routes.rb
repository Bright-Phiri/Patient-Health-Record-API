Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do 
      resources :patients do
        resources :vital_signs, only: [:create, :show]
      end
      resources :users, only: [:index, :create]
      post '/login', to: 'users#login'
      get '/statistics',to: 'patients#statistics'
    end
  end
end

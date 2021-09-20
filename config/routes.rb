Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do 
      resources :patients
      resources :vital_signs, only: [:create, :show]
      resources :users, only: [:index, :create]
      post '/login', to: 'users#login'
      get '/statistics',to: 'patients#statistics'
    end
  end
end

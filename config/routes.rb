Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, params: :_email
      resources :posts, only: [:show, :create, :destroy]
    end
  end
  post 'auth/login', to: 'authentication#login'
end

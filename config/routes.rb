Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  post '/login', to: 'auth#login'

  namespace :api, defaults: { format: 'json' } do
    resources :users, only: :index do
      get :me, on: :collection
    end
    resources :tasks, except: [:new, :edit]
  end
end

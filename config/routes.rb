Rails.application.routes.draw do
  namespace :api do
    resources :users, except: [:destroy]
    resources :tokens, only: [:create]
    resources :configurations, only: [:index]
    resources :rooms, except: [:destroy, :update]
  end
end

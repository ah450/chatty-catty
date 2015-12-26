Rails.application.routes.draw do
  namespace :api do
    resources :users, except: [:destroy]
    resources :tokens, only: [:create]
  end
end

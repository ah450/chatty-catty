Rails.application.routes.draw do
  namespace :api do
    resource :users, except: [:destroy]
  end
end

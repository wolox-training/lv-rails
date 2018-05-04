Rails.application.routes.draw do
  resources :users
  devise_for :user
end

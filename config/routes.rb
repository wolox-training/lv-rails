Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :book, only: [:show, :index]

  get '/books' => 'book#index'
end

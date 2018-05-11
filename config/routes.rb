Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  authenticate :user do
    resources :book, only: [:show, :index]
  end

  get '/books' => 'book#index'
end

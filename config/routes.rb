Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  authenticate :user do
    get '/books' => 'book#index', as: 'books'
    get '/book' => 'book#show', as: 'book'
  end
end

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  get '/books' => 'book#index', as: 'books'
  get '/book' => 'book#show', as: 'book'

  authenticate :user do
    resources :book, only: [:show, :index]
  end

  authenticate :user do
    get '/rents' => 'rent#index'
    post '/rent' => 'rent#create'
  end

end

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :books, only: %i[show index]
  resources :rents, only: %i[create index]
end

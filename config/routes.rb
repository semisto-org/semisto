Rails.application.routes.draw do
  resources :families
  resources :plants
  resources :forests
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "forests#index"

  # devise_for :users,
  #            path: 'auth',
  #            path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', unlock: 'unlock' }
end

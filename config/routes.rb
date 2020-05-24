Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users,
             path: "session",
             path_names: { sign_in: "login", sign_up: "signup", sign_out: "logout", password: "password", unlock: "unlock" }

  resources :families
  resources :plants
  resources :forests

  root to: "forests#index"
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :budgets do
    resources :payments, only: [:show, :new, :create, :destroy]
    # resources :rencontres
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

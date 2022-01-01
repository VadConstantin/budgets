Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :budgets do
    resources :payments, only: [:show, :new, :create, :destroy, :edit, :update]
    # resources :rencontres
  end
  get '/budgets/:id/reinit', to: 'budgets#reinit', as: :reinit


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

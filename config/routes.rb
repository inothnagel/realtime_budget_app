Fintrack::Application.routes.draw do

  devise_for :users
  
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  resources :data_points

  resources :metrics

  get "/accounts/all/" => "accounts#index_all"
  resources :recurs

  resources :transactions do
    member do
      get 'reverse'
    end
  end

  root :to => "accounts#index"
  resources :debtor_accounts
  resources :debtors
  resources :accounts

  post "/accounts/:id/add/" => "accounts#add"
  post "/accounts/:id/subtract/" => "accounts#subtract"

  get "transact/transaction"

  get "transact/add"
  get "/add" => "transact#add"

  get "transact/subtract"
  get "/subtract" => "transact#subtract"

  get "transact/subtract_do/:amount" => "transact#subtract_do"
  get "transact/add_do/:amount" => "transact#add_do"

  post "/debtors/:id/add/" => "debtors#add"
  post "/debtors/:id/subtract/" => "debtors#subtract"

end

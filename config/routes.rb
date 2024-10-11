Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post '/register', to: 'auth#register'
  post '/login', to: 'auth#login'
  resources :transactions, only: [:create, :index, :show]
  resources :users do
    resources :transactions, only: [:index]
  end
  get 'bitcoin_price', to: 'bitcoin_price#show'
end


Depot::Application.routes.draw do
  get "store" => 'store#index', as: 'store_direct'
  resources :products

  root 'store#index', as: 'store'
end

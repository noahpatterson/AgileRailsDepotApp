Depot::Application.routes.draw do
  resources :line_items

  resources :carts

  get "store" => 'store#index', as: 'store_direct'
  resources :products

  root 'store#index', as: 'store'
end

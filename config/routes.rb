Rails.application.routes.draw do
  resources :customers
  root :to => 'customers#index'
  get 'blacklist', to: 'customers#blacklist'
  get 'customers/:id/set_blacklist', to: 'customers#set_blacklist', as: 'set_blacklist_customer'
  get 'customers/:id/set_active', to: 'customers#set_active', as: 'set_active_customer'
  get 'block_customer_by_phone', to: 'customers#block_by_phone', as: 'block_customer_by_phone'
end

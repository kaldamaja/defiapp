Rails.application.routes.draw do
  devise_for :users
  resources :posts


devise_scope :user do
  authenticated :user do
    root 'posts#index', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end



  resources :users, :only =>[:show]

  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',   to: 'users#show',   via: 'get'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

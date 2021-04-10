Rails.application.routes.draw do
  devise_for :users

  root :to => "posts#index"

  resources :posts, :path => 'coins' do 
     resources :comments, only: [:create, :destroy, :new]

    collection do
      get :hot
      get :top
      get :newposts
      get :sideposts
    end
    
  end



  resources :users, :only =>[:show] do
    resources :relationships, only: [:create]

    collection do
      get :top
    end

  end



    resources :relationships, only: [:destroy]

  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',   to: 'users#show',   via: 'get'

   get "post/like/:post_id" => "likes#save_like", as: :like_post

   get "comment/heart/:comment_id" => "hearts#save_heart", as: :heart_comment


   get :search, controller: :posts




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  post 'follow', to: 'followships#create', as: 'follow'
  post 'addfriend', to: 'friendships#create', as: 'addfriend'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :followships, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :sessions
  resources :users
  resources :blogs do
    resources :comments, only: [:create]
  end

  get 'search', to: 'users#search', as: :search
  get 'tags/:tag', to: 'blogs#show_blog_tagged', as: :tag
  get 'auth/twitter/callback', to: 'sessions#create_with_twitter'
  root to: 'blogs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

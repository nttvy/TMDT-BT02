Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

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

Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'static_pages#top'

  resources :users, only: [:new, :create]
  # ユーザー登録
end

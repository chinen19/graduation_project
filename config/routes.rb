Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # ルートページ（トップページでメモ一覧を表示）
  root 'products#index'

  # ログイン関連
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :expenses
  resources :products
  resources :categories, only: [:index]

  # ユーザー登録
  resources :users, only: [:new, :create]

end

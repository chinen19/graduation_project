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

  resources :products, only: [:index, :new, :create, :edit, :update, :show, :destroy]
  resources :categories, only: [:index]

  # ユーザー登録
  resources :users, only: [:new, :create]

  # 静的ページのルーティングを追加
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  get 'how_to_use', to: 'static_pages#how_to_use'

end

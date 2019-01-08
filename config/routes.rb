Rails.application.routes.draw do
 
  # 先に設定されているものが優先される
  #-----------------------------------
  # 記事
  #-----------------------------------
  get   "/articles", to: "article#index"
  get   "/articles/:id",  to: "article#edit"
  get   "/articles/:name/:id",  to: "article#show"
  put   "/articles/:id", to: "article#update"
  post  "/articles/create", to: "article#create"
  #----------------------------------
  # ユーザー
  #----------------------------------
  get  '/users/:name/items', to: "user#items"
  #----------------------------------
  # コメント
  #----------------------------------
  get '/comments/:id', to: 'comment#get'
  post "comments", to: "comment#post"
  delete '/comments/:id', to: 'comment#delete'
  #---------------------------------
  # お気に入り
  #--------------------------------
  put '/favorites/:id', to: 'favorite#update'
  #---------------------------------
  # Devise 設定
  #---------------------------------
  mount_devise_token_auth_for 'User', at: 'auth',
  controllers: {
    registrations: "registrations"
  }
end

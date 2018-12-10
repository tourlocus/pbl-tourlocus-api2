Rails.application.routes.draw do
  get  "items/edit/:id",  to: "article#edit"
  get  "items/show/:name/:id",  to: "article#show" 

  get   '/users/:name/items', to: "user#items"

  get '/comments/:id', to: 'comment#get'
  
  put  "items/update/:id", to: "article#update"
  put '/comments/:id', to: 'comment#update'
  post "items/create",    to: "article#create"
  
  post "comments", to: "comment#post"

  delete '/comments/:id', to: 'comment#delete'
  
  # Devise 設定
  mount_devise_token_auth_for 'User', at: 'auth',
  controllers: {
    registrations: "registrations"
  }
end

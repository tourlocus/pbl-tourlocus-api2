Rails.application.routes.draw do
  get  "items/edit/:id",  to: "article#edit"
  get  "items/show/:name/:id",  to: "article#show" 
  get   "/articles", to: "article#index"

  get   '/users/:name/items', to: "user#items"
  
  put  "items/update/:id", to: "article#update"
  post "items/create",    to: "article#create"
  
  # Devise 設定
  mount_devise_token_auth_for 'User', at: 'auth',
  controllers: {
    registrations: "registrations"
  }
end

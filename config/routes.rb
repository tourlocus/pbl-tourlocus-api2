Rails.application.routes.draw do
  get  "items/edit/:id",  to: "article#edit"
  get  "items/show/:id",  to: "article#show" 
  get   'users/:name', to: "user#items"
  
  put  "items/update/:id", to: "article#update"
  post "items/create",    to: "article#create"

  mount_devise_token_auth_for 'User', at: 'auth',
  controllers: {
    registrations: "registrations"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
end

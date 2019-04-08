Rails.application.routes.draw do
  # Method  path-URL, to: Controller#action
  get "/books", to: "books#index"
  # get "/", to: "books#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

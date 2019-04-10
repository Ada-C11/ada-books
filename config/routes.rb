Rails.application.routes.draw do
  # Method  path-URL, to: Controller#action
  get "/books", to: "books#index", as: "books"

  get "/books/new", to: "books#new", as: "new_book"
  post "/books", to: "books#create"  #, as: "create_book"

  get "/books/:id", to: "books#show", as: "book"

  get "/books/:id/edit", to: "books#edit", as: "edit_book"
  patch "/books/:id", to: "books#update"

  delete "/books/:id", to: "books#destroy"

  root to: "books#index"

  patch "/books/:id/read", to: "books#mark_read", as: "mark_read"

  # get "/", to: "books#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

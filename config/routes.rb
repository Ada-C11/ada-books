Rails.application.routes.draw do
  root to: "books#index"
  resources :books

  # My goal route to make: GET /authors/7/books
  # authors first ... then books
  resources :authors do
    resources :books, only: [:index, :new]
  end

  # patch "/books/:id/read", to: "books#mark_read", as: "mark_read"

  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  # post "/logout", to: "users#logout", as: "logout"

  get "/users/current", to: "users#current", as: "current_user"
  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create"
end

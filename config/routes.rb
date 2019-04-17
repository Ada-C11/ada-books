Rails.application.routes.draw do
  root to: "books#index"
  resources :books

  # My goal route to make: GET /authors/7/books
  # authors first ... then books
  resources :authors do
    resources :books, only: [:index, :new]
  end

  patch "/books/:id/read", to: "books#mark_read", as: "mark_read"
end

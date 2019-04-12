Rails.application.routes.draw do
  root to: "books#index"

  resources :books

  patch "/books/:id/read", to: "books#mark_read", as: "mark_read"

end

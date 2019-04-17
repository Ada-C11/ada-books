Rails.application.routes.draw do
  root to: "books#index"
  resources :books
  resources :authors

  patch "/books/:id/read", to: "books#mark_read", as: "mark_read"

end

Rails.application.routes.draw do
  get 'favorits/create'
  get 'favorits/destroy'
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resources :book_comments, only: [:create, :destroy]
  end
end
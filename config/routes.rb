Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  root to: 'posts#index'

  resources :posts, only: %i[index create update destroy]

  match '*path' => redirect('/'), via: :get
end

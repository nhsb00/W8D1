Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create, :show]

  resources :subs

end

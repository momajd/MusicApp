Rails.application.routes.draw do
  resource :user, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :bands

  resources :albums, only: [:new, :create, :edit, :show, :update, :destroy]

  resources :tracks, only: [:new, :create, :edit, :show, :update, :destroy]
end

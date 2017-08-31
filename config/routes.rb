Rails.application.routes.draw do

  get 'relationships/create'

  get 'relationships/destroy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :blogs do
    resources :comments
    post :confirm, on: :collection
  end

  resources :contacts, only: [:new, :create] do
    collection do
      post :confirm
    end
  end

  root 'top#index'

  resources :poems ,only: [:index, :show]
  resources :users, only: [:index]
  resources :relationships, only: [:create, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end

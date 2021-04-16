Rails.application.routes.draw do
  get 'users/show'
  get 'cards/new'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'items/index'
  root to: "items#index"
  resources :items do
    resources :messages,only: [:create]
    resources :orders, only: [:index,:create]
    collection do
      get 'search'
    end

    collection do
      get 'search_product'
    end
  end

  

  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]

  resources :items, only: :order do
    post 'order', on: :member
  end
 

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

end

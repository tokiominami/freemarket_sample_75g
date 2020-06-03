Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root to: "products#index"

  resources :mypages,only: [:show] do
    resources :cards,only: [:index,:new,:show,:create] do
      collection do
        post "buy", to: "cards#pay"
      end
    end
  end
  resources :purchases, only: [:index, :create]
  resources :products,only: [:index, :new, :create, :show, :edit, :update, :destroy] do
  collection do
    get 'category/get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
    get 'category/get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
  resources :purchases,only: [:index] do
    collection do
      get 'index', to: 'purchases#index'
      post 'done', to: 'purchases#done'
    end
  end
  end
end

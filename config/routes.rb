Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  #会員用
  root 'public/homes#top'
  get 'about', to: 'public/homes#about', as: 'about'

  namespace :public do

    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'list', to: 'customers#index', as: 'list'
      end
      member do
        get 'profile', to: 'customers#show', as: 'profile'
        get 'profile/edit', to: 'customers#edit', as: 'profile/edit'
        patch 'profile', to: 'customers#update'
        get 'unsubscribe', to: 'customers#unsubscribe', as: 'unsubscribe'
        patch 'withdraw', to: 'customers#withdraw', as: 'withdraw'

        get :favorites
      end
    end

    # Public Posts
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    # Public Groups
    resources :groups, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :group_requests, only: [:create, :update, :destroy]
    end

    resources :genres, only: [:index, :show]
    #get 'genres', to: 'genres#index', as: 'genres'

    # Public Searches
    get 'searches/search', to: 'searches#search', as: 'search'

    # Public Static Pages
    get 'static_pages/terms', to: 'static_pages#terms'
  end

  # 管理者用
  namespace :admin do
    root to: 'homes#top'

    # Admin Sessions
    resources :sessions, only: [:new, :create, :destroy]

    # Admin Posts
    resources :posts, only: [:index, :show, :delete]

    #Admin Post_comments
    resources :post_comments, only: [:index, :show, :destroy]

    # Admin Genres
    resources :genres, only: [:index, :create, :edit, :update]

    # Admin Customers
    resources :customers, only: [:index, :show, :update]

    # Admin Groups
    resources :groups, only: [:index, :show, :destroy]

    # Admin Searches
    get 'searches/search', to: 'searches#search', as: 'search'

    # Admin Static Pages
    get 'static_pages/terms', to: 'static_pages#terms'
  end
end

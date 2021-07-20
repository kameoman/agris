Rails.application.routes.draw do
  get 'report', to: 'items#report'

  resources :items
  devise_for :customers, controllers: {
    customers: 'customers/customers',
    passwords: 'customers/passwords'
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get '/home/about' => 'homes#about'
    resources :item
    resources :customers

    delete 'customers/:id' => 'customers#destroy', as: 'destroy_customer'

    put '/customers/:id/update' => 'customers#update', as: 'customer_update'
    get '/customers/:id/my_page' => 'customers#edit', as: :my_page
    get '/customers/' => 'customers#index', as: :customers_index
    get '/customers/:id' => 'customers#show'
    patch '/customers/withdraw' => 'customers#withdraw'
    get '/customers/change' => 'customers#change'
  end

  devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admins/sessions#guest_sign_in'
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  get 'admin' => 'homes#top'

  namespace :admin do
    resources :items, only: [:show]
    resources :customers, only: %i[index show update edit] do
      collection do
        get 'search'
      end
    end

    get '/customers_profile' => 'customers#profile', as: :customers_profile
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  get 'record_pdfs/index'
  get 'report', to: 'items#report'

  resources :items
  delete '/customer_items_destroy_all' => 'items#destroy_all'
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
    get '/home/question' => 'homes#question'
    get '/home/mail' => 'homes#mail'
    get '/company' => 'homes#company'
    get '/terms' => 'homes#terms'
    get '/privacypolicy' => 'homes#privacypolicy'
    resources :item
    resources :customers

    delete 'customers/:id' => 'customers#destroy', as: 'destroy_customer'

    put '/customers/:id/update' => 'customers#update', as: 'customer_update'
    get '/customers/:id/my_page' => 'customers#edit', as: :my_page
    get '/customers/:id' => 'customers#index'
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

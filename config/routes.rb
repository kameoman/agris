Rails.application.routes.draw do
  devise_for :customers

   scope module: :public do
   root to: 'homes#top'
   get '/homes/about' => 'homes#about'
   resources :item

    put "/customers/update" => "customers#update", as: "customer_update"
    get "/customers/my_page/edit", to: 'customers#edit', as: :edit_mypage
    get '/customers/my_page' => 'customers#show', as: :my_page
    patch '/customers/withdraw' => 'customers#withdraw'
    get '/customers/change' => 'customers#change'

   end
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
     get 'admin' => 'homes#top'

   namespace :admin do
     resources :items, only: [:show]
     resources :customers, only:  [ :index, :show, :update, :edit]

  end



end

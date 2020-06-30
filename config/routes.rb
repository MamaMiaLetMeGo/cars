Rails.application.routes.draw do
  devise_for :users
  root 'cars#index'
  post 'cars/search'
  resources :transmissions
  resources :states
  resources :makes
  resources :cars do
    member do
      put 'like' => 'cars#like'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

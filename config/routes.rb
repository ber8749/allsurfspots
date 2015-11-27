Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users/spots' => 'users#spots'
    get '/users/awaiting_approval' => 'users#awaiting_approval'
  end

  post '/rate' => 'rater#create', :as => 'rate'

  resources :comments
  resources :contacts
  resources :images
  resources :spots do
    resources :comments
    resources :images
    get :country_options, on: :collection
    get :state_options,   on: :collection
  end

  root 'pages#index'
end

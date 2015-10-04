Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'users/spots', to: 'users#spots'
  get 'users/awaiting_approval', to: 'users#awaiting_approval'
  post '/rate' => 'rater#create', :as => 'rate'

  resources :comments
  resources :contacts
  resources :images

  constraints(id: /\d+/) do # routes with alphabetic :id are bypassed
    resources :spots do
      resources :comments
      resources :images
      get :country_options, on: :collection
      get :state_options,   on: :collection
    end
  end

  get 'spots(/:continent(/:country(/:state)))', to: 'spots#index'

  root 'pages#index'
end

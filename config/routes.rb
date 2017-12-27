Rails.application.routes.draw do
  resources :communication_data, only: [:index, :create, :update]

  resources :devices, only: [:index, :create] do
    delete :destroy, on: :collection
  end

  resources :notifications, only: [] do
    delete :destroy, on: :collection
  end

  resources :user, only: [] do
    post :sign_up, on: :collection
    post :sign_in, on: :collection
    patch :update_password, on: :collection
    get  :validate_token, on: :collection
  end
  
  resources :league_matches, only: [:index]
  resources :league_messages, only: [:create, :show]
  
  resources :league_profiles, only: [:index, :create, :show] do
    patch :update,      on: :collection
    patch :ranked_data, on: :collection
  end

  resources :league_suggestions, only: [:index] do
    patch :accept, on: :member
    patch :decline, on: :member
  end
end

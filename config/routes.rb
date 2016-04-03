Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'

  # Static pages.
  root 'static_pages#home'
  get 'about' => 'static_pages#about'

  # Log in/log out.
  get "log_in" => 'sessions#new'
  post 'log_in' => 'sessions#create'
  delete 'log_out' => 'sessions#destroy'

  # Facebook login.
  get '/auth/:provider/callback', to: 'sessions#create'

  # Sign up.
  get "sign_up" => "people#new"

  # RESTful routes for People controller.
  resources :people
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  # Because the activation link will modify the user's activation status, we
  # model the activation as a RESTful resource.

  resources :restaurants do
    put :favorite, on: :member
  end
end

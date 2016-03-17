Rails.application.routes.draw do
  
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
  # Because the activation link will modify the user's activation status, we
  # model the activation as a RESTful resource.
  
end

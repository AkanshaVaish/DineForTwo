Rails.application.routes.draw do
  
  # Static pages.
  root 'static_pages#home'
  get 'about' => 'static_pages#about'

  # Log in/log out.
  get "log_in" => 'sessions#new'
  post 'log_in' => 'sessions#create'
  delete 'log_out' => 'sessions#destroy'
  # resources :sessions
  
  # Facebook login.
  get '/auth/:provider/callback', to: 'sessions#create'
  
  # Sign up.
  get "sign_up" => "people#new"
  resources :people
  
end

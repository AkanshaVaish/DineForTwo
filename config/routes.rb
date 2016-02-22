Rails.application.routes.draw do
  root 'static_pages#home'

  get 'about' => 'static_pages#about'

  get "log_in" => 'sessions#new'
  post 'log_in' => 'sessions#create'
  delete 'log_out' => 'sessions#destroy'

  get "sign_up" => "people#new", :as => "sign_up"
  #   ^
  # This part of the syntax already creates a named route, so it isn't
  # necessary to add :as => 'sign_up' to create the named route, as seen above.
  
  resources :people
  resources :sessions
end

Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  get 'contact' => 'static_pages#contact'
  get "log_in" => 'sessions#new'
  get "sign_up" => "people#new"

  resources :people
  resources :sessions # Might not be necessary sessions has been fully implemented
end

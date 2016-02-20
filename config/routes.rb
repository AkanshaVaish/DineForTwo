Rails.application.routes.draw do
  get "log_in" => 'sessions#new', :as => "log_in"
  post 'log_in' => 'sessions#create', :as => "logged_in"
  delete 'log_out' => 'sessions#destroy', :as => "log_out"

  get "sign_up" => "people#new", :as => "sign_up"


  root 'people#new'

  resources :people
  resources :sessions
end

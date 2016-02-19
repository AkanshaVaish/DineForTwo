Rails.application.routes.draw do
  get "log_in" => 'sessions#new', :as => "log_in"

  get "sign_up" => "people#new", :as => "sign_up"

  root 'people#new'

  resources :people
  resources :sessions
end

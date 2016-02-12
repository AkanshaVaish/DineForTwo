Rails.application.routes.draw do
  get "sign_up" => "people#new", :as => "sign_up"

  root :to => 'people#new'

  resources :people
end

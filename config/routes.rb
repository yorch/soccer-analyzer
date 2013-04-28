SoccerAnalyzer::Application.routes.draw do
  devise_for :users

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get "test/index"
  
  resources :articles

  root :to => 'home#index'
  match 'index2' => 'home#index2'
end

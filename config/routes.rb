Crappr::Application.routes.draw do
  resources :suburbs
  resources :toilets, :only => [:show, :index]
  root :to => "toilets#index"
  #root :to => "index#index"
  
end

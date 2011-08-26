Crappr::Application.routes.draw do
  resources :suburbs
  
  resources :toilets, :only => [:show, :index] do
    post 'rate', :on => :member
  end
  
  namespace :api do
    get "nearby" => "toilets#nearby_crappers"
    get "top10" => "toilets#top_10"
  end
  
  root :to => "index#index"
  
end

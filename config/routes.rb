Crappr::Application.routes.draw do
  resources :suburbs
  
  resources :toilets, :only => [:show, :index] do
    post 'rate', :on => :member
  end
  
  namespace :api do
    resources :toilets, :only => [:show, :index] do
      post 'rate', :on => :member
      get 'reviews', :on => :member
      post 'reviews', :action => :create_review, :on => :member
      get 'nearby', :on => :collection
      get 'top_10', :on => :collection
    end
    
    resources :reviews, :only => [:create] do
    end
  end
  
  root :to => "index#index"
  
end

Crappr::Application.routes.draw do
  resources :suburbs, :only => [:show, :index]
  resources :reviews, :only => [:create]
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
    
    resources :reviews, :only => [:create, :index] do
    end
    
    resources :suburbs, :only => [:show, :index] do
      get 'toilets', :on => :member
    end
  end
  
  match "about" => "pages#about"
  root :to => "pages#home"
  
end

Crappr::Application.routes.draw do
  resources :suburbs, :only => [:show, :index] do
    resources :toilets, :only => [:index]
  end

  resources :reviews, :only => [:index]
  resources :toilets, :only => [:show, :index] do
    resources :reviews, :only => [:index, :create]
  end
  
  match "about" => "pages#about"
  root :to => "pages#home"
  
end

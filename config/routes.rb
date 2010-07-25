Redactify::Application.routes.draw do |map|

  resources :users, :only => [:show, :update] do
    collection do
      get :mentions
      get :retweeted_by_me
      get :retweets_of_me
    end
    resources :spoilers
  end
  
  resources :tweets, :only => [:show]

  resource :retweet, :only => [:create]
  resource :timeline, :only => [:show, :update, :create]
  resources :lists, :only => [:show, :update]
  resources :searches, :only => [:index, :create]
  resource :trends, :only => [:show, :update]
  resource :rate_limit, :only => [:update]
  
  resource :session
  
  match '/login', :to => 'sessions#new', :as => :login
  match '/logout', :to => 'sessions#destroy', :as => :logout
  match '/oauth_callback', :to => 'sessions#oauth_callback', :as => 'oauth_callback'

  root :to => "static#index"

  match "/:action", :controller => 'static', :as => "static"

end

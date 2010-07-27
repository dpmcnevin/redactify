Redactify::Application.routes.draw do

  resources :users, :only => [:show, :update] do
    resources :spoilers
  end
  
  get "/mentions" => "users#show", :section => "mentions", :as => "mentions"
  get "/retweeted_by_me" => "users#show", :section => "retweeted_by_me", :as => "retweeted_by_me"
  get "/retweets_of_me" => "users#show", :section => "retweets_of_me", :as => "retweets_of_me"
  
  resources :tweets, :only => [:show]

  resource :retweet, :only => [:create]
  resource :timeline, :only => [:show, :update, :create]
  resources :lists, :only => [:show, :update]
  resources :searches, :only => [:index, :create]
  resource :trends, :only => [:show, :update]
  resource :rate_limit, :only => [:update]
  
  get "/about" => 'static#about', :as => "about"

  root :to => "static#index"

end

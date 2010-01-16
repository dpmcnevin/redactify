ActionController::Routing::Routes.draw do |map|
  
  map.resources :users, :only => [:show, :update], :has_many => :spoilers
  map.resources :tweets, :only => [:show]
  map.resource :timeline, :only => [:show, :update, :create]
  map.resources :lists, :only => [:show, :update]
  map.resources :searches, :only => [:create]

  map.static '/:action', :controller => 'static'

  map.root :timeline
end

ActionController::Routing::Routes.draw do |map|
  
  map.resources :users, :only => [:show, :new], :has_many => :spoilers
  map.resources :tweets, :only => [:show]
  map.resource :timeline, :only => [:show, :update, :create]
  map.resources :lists, :only => [:show, :update]
  
  # map.timeline "/timeline", :controller => "timeline", :action => :index

  
  map.static '/:action', :controller => 'static'

  # map.root :controller => 'static', :action => 'index'
  map.root :timeline
end

ActionController::Routing::Routes.draw do |map|
  
  map.resources :users, :only => [:show], :has_many => :spoilers
  map.resources :tweets, :only => [:show]
  map.resources :timeline, :only => [:index]
  
  map.timeline "/timeline", :controller => "timeline", :action => :index
  
  map.static '/:action', :controller => 'static'

  # map.root :controller => 'static', :action => 'index'
  map.root :timeline
end

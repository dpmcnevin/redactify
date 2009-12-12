ActionController::Routing::Routes.draw do |map|
  
  map.resources :users, :only => [:show], :has_many => :spoilers
  
  map.timeline '/timeline', :controller => :users, :action => :show
  
  map.static '/:action', :controller => 'static'

  # map.root :controller => 'static', :action => 'index'
  map.root :timeline
end

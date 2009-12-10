ActionController::Routing::Routes.draw do |map|
  
  map.resources :users, :only => [:show], :has_many => :spoilers
  
  map.static '/:action', :controller => 'static'

  map.root :controller => 'static', :action => 'index'
end

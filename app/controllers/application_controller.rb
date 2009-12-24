class ApplicationController < ActionController::Base
  helper :all
    
  rescue_from Net::HTTPFatalError do |exception|
    # render "static/twitter_error"
    flash[:error] = "There was an error connecting to Twitter"
    redirect_to root_path
  end  
    
  private
  
  def check_login
    unless current_user
      redirect_to :controller => :static, :action => :index
    end
  end
  
end

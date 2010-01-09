class ApplicationController < ActionController::Base
  helper :all
  
  before_filter :set_up_twitter_params
    
  rescue_from Net::HTTPFatalError do |exception|
    # render "static/twitter_error"
    flash[:error] = "There was an error connecting to Twitter"
    redirect_to root_path
  end  
      
  private
  
  def set_up_twitter_params
    params[:twitter] = {} unless params[:twitter]
  end
  
  def check_login
    unless current_user
      redirect_to :controller => :static, :action => :index
    end
  end
  
end

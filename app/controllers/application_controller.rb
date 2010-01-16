class ApplicationController < ActionController::Base
  helper :all
  
  before_filter :set_up_twitter_params
    
  rescue_from Net::HTTPFatalError do |exception|
    flash.now[:error] = "There was an error connecting to Twitter"
    redirect_to root_path
  end  
  
  rescue_from TwitterAuth::Dispatcher::Error do |exception|
    flash.now[:error] = "There was an error connecting to Twitter"
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
  
  def load_user
    @user = current_user
  end
  
  def update_latest_tweet
    session[:latest_id] = @timeline.first.id unless params[:page]
  end
  
  def load_new_tweets(new_tweets)
    
  end
  
end

class ApplicationController < ActionController::Base
  helper :all
      
  rescue_from Net::HTTPFatalError do |exception|
    flash[:error] = "There was an error connecting to Twitter"
    redirect_to root_path
  end
  
  rescue_from SocketError do |exception|
    flash[:error] = "There was an error connecting to Twitter"
    redirect_to root_path
  end  
  
  rescue_from TwitterAuth::Dispatcher::Error do |exception|
    flash[:error] = "There was an error connecting to Twitter"
    redirect_to root_path
  end
      
  private
  
  def check_login
    unless current_user
      redirect_to :controller => :static, :action => :index
    end
  end
  
  def load_user
    @user = current_user
  end
  
  def load_trends
    @trends = @user.trends
  end
  
  def update_latest_tweet
    session[:latest_id] = @timeline.first.id if !@timeline.empty? && params[:page] == 1
  end
  
  def load_new_tweets(new_tweets)
    if new_tweets.empty?
      render :update do |page|
        # page << update_trends
        page << update_rate_limit
      end
    else
      session[:latest_id] = new_tweets.first.id
      render "timelines/update", :format => :js
    end
  end
  
end

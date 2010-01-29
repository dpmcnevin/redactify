class SearchesController < ApplicationController

  before_filter :check_login
  before_filter :load_user
  after_filter :update_latest_tweet, :only => :create
  
  def create
    @trends = @user.trends
    @timeline = @user.spoiler_free_timeline(:search => true, :q => params[:q])
    render "timelines/show"
  end
  
  def update
    @new_tweets = @user.spoiler_free_timeline(:screen_name => params[:id], :since_id => session[:latest_id])
    load_new_tweets(@new_tweets)
  end

end

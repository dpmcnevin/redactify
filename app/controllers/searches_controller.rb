class SearchesController < ApplicationController

  before_filter :check_login
  before_filter :load_user
  before_filter :load_trends, :only => [:index, :create]
  after_filter :update_latest_tweet, :only => :create
  
  def index
    @timeline = @user.spoiler_free_timeline(:search => true, :q => params[:q])
    render "timelines/show"
  end
  
  def create
    @timeline = @user.spoiler_free_timeline(:search => true, :q => params[:q])
    render "timelines/show"
  end
  
  def update
    @new_tweets = @user.spoiler_free_timeline(:screen_name => params[:id], :since_id => session[:latest_id])
    load_new_tweets(@new_tweets)
  end

end

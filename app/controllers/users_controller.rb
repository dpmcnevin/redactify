class UsersController < ApplicationController

  before_filter :check_login
  before_filter :load_user
  before_filter :load_trends, :only => [:show]
  after_filter :update_latest_tweet, :only => :show
  
  def show
    @page = params[:page] ||= 1
    @get_more_url = user_path(:id => params[:id], :page => @page.to_i + 1)
    @update_tweets_url = user_path(:id => params[:id])
    @timeline = @user.spoiler_free_timeline(:screen_name => params[:id], :page => @page)
    render "timelines/show"
  end
  
  def update
    @new_tweets = @user.spoiler_free_timeline(:screen_name => params[:id], :since_id => session[:latest_id])
    load_new_tweets(@new_tweets)
  end
  
end

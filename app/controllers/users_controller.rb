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
  
  ## FIXME
  def update
    @new_tweets = @user.spoiler_free_timeline(:screen_name => params[:id], :since_id => session[:latest_id])
    load_new_tweets(@new_tweets)
  end
  
  def mentions
    @page = params[:page] ||= 1
    @get_more_url = mentions_users_path(:page => @page.to_i + 1)
    @update_tweets_url = mentions_users_path
    @timeline = @user.mentions(:page => @page)
    respond_to do |format|
      format.html { render "timelines/show" }
      format.js { render :partial => "timelines/tweets", :locals => { :tweets => @timeline } }
    end
  end
  
  def retweeted_by_me
    @page = params[:page] ||= 1
    @get_more_url = retweeted_by_me_users_path(:page => @page.to_i + 1)
    @update_tweets_url = retweeted_by_me_users_path
    @timeline = @user.retweeted_by_me(:page => @page)
    respond_to do |format|
      format.html { render "timelines/show" }
      format.js { render :partial => "timelines/tweets", :locals => { :tweets => @timeline } }
    end
  end
  
  def retweets_of_me
    @page = params[:page] ||= 1
    @get_more_url = retweets_of_me_users_path(:page => @page.to_i + 1)
    @update_tweets_url = retweets_of_me_users_path
    @timeline = @user.retweets_of_me(:page => @page)
    @timeline.map {|t| t.tweet["retweeted_by"] = @user.get_retweeted_by(t.tweet) }
    respond_to do |format|
      format.html { render "timelines/show" }
      format.js { render :partial => "timelines/tweets", :locals => { :tweets => @timeline } }
    end
  end
  
end

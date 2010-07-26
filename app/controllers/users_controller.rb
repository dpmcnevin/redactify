class UsersController < ApplicationController

  before_filter :check_login
  before_filter :load_user
  # before_filter :set_urls, :only => [:show]
  before_filter :load_trends, :only => [:show]
  after_filter :update_latest_tweet, :only => [:show]
  
  def show
    case params[:section]
      when "mentions"
        @get_more_url = mentions_path(:page => @page.to_i + 1)
        @update_tweets_url = mentions_path
        @timeline = @user.spoiler_free_timeline(:page => @page, :section => "mentions")
      when "retweeted_by_me"
        @get_more_url = retweeted_by_me_path(:page => @page.to_i + 1)
        @update_tweets_url = retweeted_by_me_path
        @timeline = @user.spoiler_free_timeline(:page => @page, :section => "retweeted_by_me")
      when "retweets_of_me"
        @get_more_url = retweets_of_me_path(:page => @page.to_i + 1)
        @update_tweets_url = retweets_of_me_path
        @timeline = @user.spoiler_free_timeline(:page => @page, :section => "retweets_of_me")
        @timeline.map {|t| t.tweet["retweeted_by"] = @user.get_retweeted_by(t.tweet) }
      else
        @get_more_url = user_path(:id => params[:id], :page => @page.to_i + 1)
        @update_tweets_url = user_path(:id => params[:id])
        @timeline = @user.spoiler_free_timeline(:screen_name => params[:id], :page => @page)
    end
    
    respond_to do |format|
      format.html { render "timelines/show" }
      format.js { render :partial => "timelines/tweets", :locals => { :tweets => @timeline } }
    end
  end
  
  ## FIXME
  def update
    @new_tweets = @user.spoiler_free_timeline(:screen_name => params[:id], :since_id => session[:latest_id])
    load_new_tweets(@new_tweets)
  end
  
  private
  
  def set_urls(section = "user")
    @page = params[:page] ||= 1
    @get_more_url = mentions_path(:page => @page.to_i + 1)
    @update_tweets_url = mentions_path
  end
  
end

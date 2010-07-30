class UsersController < ApplicationController

  before_filter :check_login
  before_filter :load_user
  # before_filter :set_urls, :only => [:show]
  before_filter :load_trends, :only => [:show]
  after_filter :update_latest_tweet, :only => [:show]
  
  def show   
    @page = params[:page] ||= 1
     
    case params[:section]
      when "mentions"
        get_timeline("mentions", :section => "mentions")
      when "retweeted_by_me"
        get_timeline("retweeted_by_me", :section => "retweeted_by_me")
      when "retweets_of_me"
        get_timeline("retweets_of_me", :section => "retweets_of_me")
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
  
  def get_timeline(section, options = {})
    path = "#{section}_path"
    @get_more_url = self.send(path, options.merge(:page => @page.to_i + 1))
    @update_tweets_url = self.send(path)
    @timeline = @user.spoiler_free_timeline(:page => @page, :section => section)
  end
  
end

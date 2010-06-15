class TimelinesController < ApplicationController
  before_filter :check_login
  before_filter :load_user
  before_filter :load_trends, :only => [:show]
  after_filter :update_latest_tweet, :only => :show
  
  def show
    @page = params[:page] ||= 1
    @get_more_url = timeline_path(:page => @page.to_i + 1)
    @update_tweets_url = timeline_path
    @timeline = @user.spoiler_free_timeline(:page => @page)
    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @timeline.to_json }
    end
  end

  def create
    @user.post_tweet(params[:tweet])
    if @user.errors.empty?
      flash[:notice] = "New Tweet Posted"
    else
      flash[:error] = "There was a problem posting the twitter update: #{current_user.errors[:tweet]}"
    end
    redirect_to timeline_path
  end
  
  def update
    @new_tweets = @user.spoiler_free_timeline(:since_id => session[:latest_id])
    @new_tweets.map {|tweet| tweet.css_classes = "tweet new"}
    load_new_tweets(@new_tweets)
  end

end

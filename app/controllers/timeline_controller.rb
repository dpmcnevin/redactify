class TimelineController < ApplicationController
  before_filter :check_login
  
  def index
    @user = current_user
    @page = params[:twitter][:page].to_i + 1 if params[:twitter] && params[:twitter][:page]
    @timeline = @user.spoiler_free_timeline(params[:twitter] || {})
    session[:latest_id] = @timeline.first.id unless params[:twitter] && params[:twitter][:page]
    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @timeline.to_json }
    end
  end

  def create
    @user = current_user
    @user.post_tweet(params[:tweet])
    if @user.errors.empty?
      flash[:notice] = "New Tweet Posted"
    else
      flash[:error] = "There was a problem posting the twitter update: #{current_user.errors[:tweet]}"
    end
    redirect_to timeline_path
  end
  
  def new
    @user = current_user
    @new_tweets = @user.spoiler_free_timeline(params[:twitter].merge("since_id" => session[:latest_id]))
    
    ## FIXME testing
    @new_tweets.last.tweet["text"] = params.inspect.to_s
    
    if @new_tweets.empty?
      render :upadate do |page|
        page << update_rate_limit
      end
    else
      session[:latest_id] = @new_tweets.first.id
      render :format => :js
    end
  end
  
end

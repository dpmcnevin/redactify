class TimelineController < ApplicationController
  before_filter :check_login
  
  def index
    @user = current_user
    @page = params[:page].to_i + 1 if params[:page]
    @timeline = @user.spoiler_free_timeline(params)
    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @timeline.to_json }
    end
  end

  def create
    # debugger
    current_user.post_tweet(params[:tweet])
    if current_user.errors.empty?
      flash[:notice] = "New Tweet Posted"
    else
      flash[:error] = "There was a problem posting the twitter update: #{current_user.errors[:tweet]}"
    end
    redirect_to timeline_path
  end
  
end

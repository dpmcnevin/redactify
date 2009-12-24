class TimelineController < ApplicationController
  before_filter :check_login
  before_filter :check_authorized_users
  
  def index
    @user = current_user
    @rate_limit = @user.rate_limit_status
    @page = params[:page].to_i + 1 if params[:page]
    @timeline = @user.spoiler_free_timeline(params)
  end
  
  private
  
  def check_authorized_users
    users = ["mental_thinking", "redactify", "spoiler_free", "ignignokt_"]
    unless users.include? current_user.login
      flash[:error] = "This is a closed test system for now, check back later for beta signups"
      redirect_to root_path
    end
  end
end

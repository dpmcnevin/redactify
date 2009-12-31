class TimelineController < ApplicationController
  before_filter :check_login
  
  def index
    @user = current_user
    @page = params[:page].to_i + 1 if params[:page]
    @timeline = @user.spoiler_free_timeline(params)
  end

end

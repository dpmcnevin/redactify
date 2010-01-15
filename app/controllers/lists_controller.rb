class ListsController < ApplicationController

  before_filter :check_login
  before_filter :load_user
  after_filter :update_latest_tweet, :only => :show
  
  def show
    @page = params[:page] ||= 1
    @get_more_url = list_path(:id => params[:id], :page => @page.to_i + 1)
    @update_tweets_url = list_path(params[:id])
    @timeline = @user.spoiler_free_timeline(:list_id => params[:id], :page => @page)
    render "timelines/index"
  end
  
  def update
    
  end


end

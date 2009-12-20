class SpoilersController < ApplicationController
  
  before_filter :get_user
  
  layout false
  
  def index
    @spoilers = @user.spoilers
  end
  
  def create
    @spoiler = @user.spoilers.new(params[:spoiler])
    if @spoiler.save
      flash[:notice] = "Tag Created for: #{@spoiler.name}"
    else
      flash[:error] = "There was a problem creating the tag"
    end
    
    respond_to do |format|
      format.html { redirect_to timeline_path }
    end
  end
  
  def destroy
    @spoiler = @user.spoilers.find(params[:id])
    if @spoiler.destroy
      flash[:notice] = "Tag Removed for: #{@spoiler.name}"
    else
      flash[:error] = "There was a problem removing the tag"
    end
    redirect_to timeline_path
  end
  
  private
  
  def get_user
    @user = current_user
  end
end

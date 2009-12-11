class SpoilersController < ApplicationController
  
  before_filter :get_user
  
  layout false
  
  def index
    @spoilers = @user.spoilers
  end
  
  def create
    @user.spoilers.create(params[:spoiler])
    respond_to do |format|
      format.html { redirect_to @user }
    end
  end
  
  def destroy
    @spoiler = @user.spoilers.find(params[:id])
    if @spoiler.destroy
      flash[:notice] = "Tag Removed"
    else
      flash[:error] = "There was a problem removing the tag"
    end
    redirect_to @user
  end
  
  private
  
  def get_user
    # @user = User.find(params[:user_id])
    @user = current_user
  end
end

class SpoilersController < ApplicationController
  
  before_filter :get_user
  
  layout false

  def index
  end

  def create
    @spoiler = @user.spoilers.new(params[:spoiler])
    if @spoiler.save
      flash[:notice] = "Tag Created for: #{@spoiler.name}"
    else
      flash[:error] = "There was a problem creating the tag: #{@spoiler.errors.full_messages.join("<br />")}"
    end
            
    respond_to do |format|
      format.html { redirect_to request.env["HTTP_REFERER"] }
    end
  end
  
  def destroy
    @spoiler = @user.spoilers.find(params[:id])
    if @spoiler.destroy
      flash[:notice] = "Tag Removed for: #{@spoiler.name}"
    else
      flash[:error] = "There was a problem removing the tag<br />#{@spoiler.errors.full_messages.join("<br />")}"
    end
    redirect_to request.env["HTTP_REFERER"]
  end
  
  private
  
  def get_user
    @user = current_user
  end
end

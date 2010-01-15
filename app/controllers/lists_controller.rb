class ListsController < ApplicationController

  before_filter :check_login
  before_filter :load_user
  
  def show
    @timeline = @user.spoiler_free_timeline(:list_id => params[:id])
    render "timeline/index"
  end
  
  private
  
  def load_user
    @user = current_user
  end

end

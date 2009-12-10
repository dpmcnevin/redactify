class SpoilersController < ApplicationController
  
  before_filter :get_user
  
  layout false
  
  def index
    @spoilers = @user.spoilers
  end
  
  private
  
  def get_user
    @user = User.find(params[:user_id])
  end
end

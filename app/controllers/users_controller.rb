class UsersController < ApplicationController
  
  before_filter :check_login
  before_filter :check_authorized_users
  
  def show
    # @user = User.find(params[:id])
    @user = current_user
    @rate_limit = @user.rate_limit_status
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

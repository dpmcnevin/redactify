class UsersController < ApplicationController
  
  before_filter :check_login
  
  def show
    # @user = User.find(params[:id])
    @user = current_user
    @rate_limit = @user.rate_limit_status
  end

end

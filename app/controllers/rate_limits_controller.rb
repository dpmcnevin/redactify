class RateLimitsController < ApplicationController
  
  before_filter :check_login
  before_filter :load_user
  
  def update
    @rate_limit = @user.rate_limit_status
    respond_to do |format|
      format.js { render :partial => "users/rate_limit", :locals => { :rate_limit => @rate_limit }  }
    end
  end
  
end

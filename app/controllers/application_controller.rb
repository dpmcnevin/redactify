class ApplicationController < ActionController::Base
  helper :all
    
  private
  
  def check_login
    unless current_user
      redirect_to :controller => :static, :action => :index
    end
  end
  
end

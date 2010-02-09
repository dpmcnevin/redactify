class RetweetsController < ApplicationController
  
  before_filter :check_login
  before_filter :load_user
  
  def create
    @tweet_id = params[:tweet_id]
    if current_user.retweet(@tweet_id)
      flash[:notice] = "Retweeted!"
      redirect_to timeline_path
    end
  end

end

class TweetsController < ApplicationController
  
  def show
    @tweet = current_user.get_tweet(params[:id])
  end

end

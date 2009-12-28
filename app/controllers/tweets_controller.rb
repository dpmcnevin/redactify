class TweetsController < ApplicationController
  
  def show
    @user = current_user
    @tweet = @user.get_tweet(params[:id])
  end

end

class TweetsController < ApplicationController
  
  def show
    @user = current_user
    @tweet = @user.get_tweet(params[:id])
    respond_to do |format|
      format.js { render :partial => @tweet }
    end
  end

end
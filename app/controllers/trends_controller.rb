require 'open-uri'

class TrendsController < ApplicationController

  before_filter :load_user, :only => [:update]

  def update
    @trends = @user.trends
  end

end

require 'open-uri'

class TrendsController < ApplicationController

  before_filter :load_user, :only => [:update]
  before_filter :load_trends, :only => [:update]

  def update
  end

end

module ApplicationHelper
  
  def auto_link_twitter(txt, options = {})
  	txt.scan(/(^|\W|\s+)(#|@)(\w{1,40})/).each do |match|
  	  if match[1] == "#"
  	    txt.gsub!(/##{match.last}/, link_to("##{match.last}", searches_path(:q => match.last), options.merge({:method => :post})))
	    elsif match[1] == "@"
	      txt.gsub!(/@#{match.last}/, link_to("@#{match.last}", user_path(match.last), options))
		  end
  	end
  	txt.html_safe
  end
  
  def update_rate_limit
    # update_page do |page|
    #   page["#rate_limit"].replace_html :partial => "users/rate_limit", :locals => { :rate_limit => @user.rate_limit_status }
    # end
    "$('#rate_limit').html('#{render :partial => "users/rate_limit", :locals => { :rate_limit => @user.rate_limit_status }}');"
  end
  
  def update_trends
    update_page do |page|
      page["twitter_trends"].replace_html :partial => "users/trends"
    end
  end
  
end

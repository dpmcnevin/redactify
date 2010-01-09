# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def auto_link_twitter(txt)
  	txt.scan(/(^|\W|\s+)(#|@)(\w{1,15})/).each do |match|
  	  if match[1] == "#"
  	    txt.gsub!(match.last, link_to(match.last, "http://twitter.com/search/?q=##{match.last}", :target => "_blank"))
	    elsif match[1] == "@"
	      txt.gsub!(match.last, link_to(match.last, "http://twitter.com/#{match.last}", :target => "_blank"))
		  end
  	end
  	txt
  end
  
  def update_rate_limit
    update_page do |page|
      page["rate_limit"].replace_html :partial => "users/rate_limit", :locals => { :rate_limit => @user.rate_limit_status }
      page["rate_limit"].highlight
    end
  end
  
end

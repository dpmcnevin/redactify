# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def auto_link_twitter(txt, options = {:target => "_blank"})
  	txt.scan(/(^|\W|\s+)(#|@)(\w{1,40})/).each do |match|
  	  if match[1] == "#"
  	    txt.gsub!(/##{match.last}/, link_to("##{match.last}", "http://twitter.com/search/?q=##{match.last}", options))
	    elsif match[1] == "@"
	      txt.gsub!(/@#{match.last}/, link_to("@#{match.last}", "http://twitter.com/#{match.last}", options))
		  end
  	end
  	txt
  end
  
  def update_rate_limit
    update_page do |page|
      page["rate_limit"].replace_html :partial => "users/rate_limit", :locals => { :rate_limit => @user.rate_limit_status }
    end
  end
  
end

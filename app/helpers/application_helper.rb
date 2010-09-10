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

  def retweeted_by_links(tweet)
    links = tweet.tweet["retweeted_by"].map do |t|
      link_to t["screen_name"], "http://twitter.com/#{t["screen_name"]}"
    end
    
    links.join(", ").html_safe
  end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def auto_link_twitter(txt)
  	if match = txt.match(/.*?(@)((?:[a-z][a-z]+))(:|\s)/i)
  		user = match[2]
  		txt.gsub!(user, '<a href="http://twitter.com/' + user + '">' + user + '</a>')
  	end
  	txt
  end

end

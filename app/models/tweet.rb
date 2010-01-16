require "cgi"

class Tweet
  
  attr_reader :tweet
  
  def initialize(tweet, type = :normal)
    @tweet = tweet
    @type = type
  end
  
  def search?
    @type == :search
  end
  
  def id
    # return @tweet["from_user_id"] if search?
    @tweet["id"]
  end
  
  def text
    @tweet["text"]
  end
  
  def screen_name
    return @tweet["from_user"] if search?
    @tweet["user"]["screen_name"]
  end
  
  def profile_image_url
    return @tweet["profile_image_url"] if search?
    @tweet["user"]["profile_image_url"]
  end
  
  def protected?
    return false if search?
    @tweet["user"]["protected"]
  end
  
  def created_at
    @tweet["created_at"]
  end
  
  def source
    return CGI.unescapeHTML(@tweet["source"]) if search?
    @tweet["source"]
  end
  
  def in_reply_to_screen_name
    return @tweet["to_user_id"] if search?
    @tweet["in_reply_to_screen_name"]
  end
  
  def in_reply_to_status_id
    @tweet["in_reply_to_status_id"]
  end
  
end
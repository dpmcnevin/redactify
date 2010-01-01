class Tweet
  
  attr_reader :tweet
  
  def initialize(tweet)
    @tweet = tweet
  end
  
  def id
    @tweet["id"]
  end
  
  def text
    @tweet["text"]
  end
  
  def screen_name
    @tweet["user"]["screen_name"]
  end
  
  def profile_image_url
    @tweet["user"]["profile_image_url"]
  end
  
  def protected?
    @tweet["user"]["protected"]
  end
  
  def created_at
    @tweet["created_at"]
  end
  
  def source
    @tweet["source"]
  end
  
  def in_reply_to_screen_name
    @tweet["in_reply_to_screen_name"]
  end
  
  def in_reply_to_status_id
    @tweet["in_reply_to_status_id"]
  end
  
end
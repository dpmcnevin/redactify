class Retweet < Tweet
  
  attr_accessor :original_tweet
  
  def initialize(tweet,type = :normal)
    super
    @original_tweet = tweet
    @tweet = @original_tweet["retweeted_status"]
    @type = type
    @css_classes = ["tweet", "retweet"]
  end
  
  def id
    @original_tweet["id"]
  end
  
  def original_profile_image_url
    @original_tweet["user"]["profile_image_url"]
  end
  
  def original_screen_name
    @original_tweet["user"]["screen_name"]
  end
    
end

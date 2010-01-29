class Retweet < Tweet
  
  attr_accessor :original_tweet
  
  def initialize(tweet,tags,type = :normal)
    @original_tweet = tweet
    @tweet = @original_tweet["retweeted_status"]
    @type = type
  end
  
  def original_profile_image_url
    @original_tweet["user"]["profile_image_url"]
  end
  
  def original_screen_name
    @original_tweet["user"]["screen_name"]
  end
    
end

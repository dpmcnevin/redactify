class Redacted < Tweet

  attr_accessor :tweet, :tags
  
  def initialize(tweet,tags,type = :normal)
    @tweet = tweet
    @tags = tags
    @type = type
  end
  
end

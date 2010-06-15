class Redacted < Tweet

  attr_accessor :tweet, :tags
  
  def initialize(tweet,tags,type = :normal)
    @tweet = tweet
    @tags = tags
    @type = type
    @css_classes = ["tweet", "redacted"]
  end
  
end

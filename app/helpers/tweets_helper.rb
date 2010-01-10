module TweetsHelper
  
  def tweet_output(tweet)
    auto_link(auto_link_twitter(tweet), :link => :urls, :html => { :target => '_blank'} )
  end
  
end

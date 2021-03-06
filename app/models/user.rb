require "yaml"
require "cgi"
require "open-uri"

class User < TwitterAuth::GenericUser

  has_many :spoilers

  def assign_tweets(tweets, type)
    tweets.map do |tweet|
      if spoiler?(tweet["text"])
        Redacted.new(tweet,spoiled_on(tweet["text"]), type)
      elsif tweet["retweeted_status"]
        Retweet.new(tweet, type)
      else
        Tweet.new(tweet, type)
      end
    end
  end

  def spoiler_free_timeline(options = {})
    
    if options[:search]
      tweets = search(options)["results"]
      type = :search
    else
      tweets = timeline(options)
      type = :normal
    end
            
    assign_tweets(tweets, type)
  end
  
  def get_retweeted_by(tweet)
    twitter.get("http://api.twitter.com/1/statuses/#{tweet["id"]}/retweeted_by.json")
  end
  
  def get_lists
    begin
      twitter.get("http://api.twitter.com/1/#{login}/lists.json")["lists"]
    rescue
      # return File.open("#{Rails.root}/db/test_lists.yml") { |file| YAML.load(file) } if Rails.env == "development"
      return []
    end
  end
  
  def get_tweet(id)
    tweet = twitter.get("/statuses/show/#{id}.json")
    if tweet["retweeted_status"]
      Retweet.new(tweet)
    else
      Tweet.new(tweet)
    end
  end
  
  def trends
    url = "http://search.twitter.com/trends.json"
    puts "TWITTER: Getting URL: #{url}" if Rails.env == "development"
    twitter.get(url)["trends"]
    # return []
  end
  
  def rate_limit_status
    begin
      twitter.get("http://twitter.com/account/rate_limit_status.json")
    rescue
      {}
    end
  end
  
  def spoiler?(tweet)
    return spoilers.any? {|spoiler| tweet =~ Regexp.new(Regexp.escape(spoiler.name), Regexp::IGNORECASE)}
  end
  
  def spoiled_on(tweet)
    spoilers.reject {|spoiler| tweet !~ Regexp.new(Regexp.escape(spoiler.name), Regexp::IGNORECASE)}
  end
  
  def popular_tags
    my_spoilers = spoilers.collect(&:name)
    conditions = []
    conditions = ["name NOT IN (?)", my_spoilers] unless my_spoilers.empty?
    cols = Spoiler.column_names.collect {|c| "spoilers.#{c}"}.join(",")
    
    Spoiler.find(:all, 
      :select => "#{cols},count(*) as count", 
      :conditions => conditions, 
      :order => "count DESC",
      :limit => 5,
      :group => "name, #{cols}")
  end
  
  def post_tweet(tweet)
    if tweet.length <= 140
      twitter.post('/statuses/update.json', 'status' => tweet["status"], 'in_reply_to_status_id' => tweet["in_reply_to_status_id"]) 
    else
      errors.add("tweet", "Status update over 140 characters")
    end
  end
  
  def retweet(tweet_id)
    url = "http://api.twitter.com/1/statuses/retweet/%s.json"
    twitter.post(url % tweet_id)
  end
  
  private
  
  def search(options)
    options = HashWithIndifferentAccess.new(options)
    
    url = "http://search.twitter.com/search.json?rpp=50&q=#{CGI.escape(options[:q])}"
    # url << "?#{options.to_query}" unless options.empty?
    
    puts "TWITTER: Getting URL: #{url}" if Rails.env == "development"
    twitter.get(url)
  end
  
  def timeline(options)
    
    options = HashWithIndifferentAccess.new(options)
    
    url = case
      when options["list_id"] 
        "http://api.twitter.com/1/#{login}/lists/#{options["list_id"]}/statuses.json"
      when options["screen_name"] 
        "/statuses/user_timeline/#{options["screen_name"]}.json"
      when options[:section] == "mentions"
        "http://api.twitter.com/1/statuses/mentions.json"
      when options[:section] == "retweeted_by_me"
        "http://api.twitter.com/1/statuses/retweeted_by_me.json"
      when options[:section] == "retweets_of_me"
        "http://api.twitter.com/1/statuses/retweets_of_me.json"
      else 
        "/statuses/home_timeline.json"
    end
    
    url << "?#{options.to_query}" unless options.empty?
    
    puts "TWITTER: Getting URL: #{url}" if Rails.env == "development"
     
    ## Test from local files    
    # tweets = File.open("#{Rails.root}/db/test_tweets.yml") { |file| YAML.load(file) }
    # tweets.first["text"] = url
    # return tweets          
    
    ## Get data from twitter
    twitter.get(url)

  end
  
end

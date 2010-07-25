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
  
  def mentions(options = {})
    tweets = twitter.get("http://api.twitter.com/1/statuses/mentions.json?page=#{options[:page]}")
    assign_tweets(tweets, :normal)
  end
  
  def retweeted_by_me(options = {})
    tweets = twitter.get("http://api.twitter.com/1/statuses/retweeted_by_me.json")
    assign_tweets(tweets, :normal)
  end
  
  def retweets_of_me(options = {})
    tweets = twitter.get("http://api.twitter.com/1/statuses/retweets_of_me.json")
    assign_tweets(tweets, :normal)
  end
  
  def get_retweeted_by(tweet)
    twitter.get("http://api.twitter.com/1/statuses/#{tweet["id"]}/retweeted_by.json")
  end
  
  def get_lists
    begin
      # twitter.get("/1/#{login}/lists.json")["lists"]
      twitter.get("http://api.twitter.com/1/#{login}/lists.json")["lists"]
      # return []
    rescue
      # return File.open("#{RAILS_ROOT}/db/test_lists.yml") { |file| YAML.load(file) } if RAILS_ENV == "development"
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
    puts "TWITTER: Getting URL: #{url}"
    twitter.get(url)["trends"]
    # return []
  end
  
  def rate_limit_status
    begin
      twitter.get("http://twitter.com/account/rate_limit_status.json")
    rescue
      File.open("#{RAILS_ROOT}/db/test_rate_limit.yml") { |file| YAML.load(file) }  if RAILS_ENV == "development"
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
    
    puts "TWITTER: Getting URL: #{url}"
    twitter.get(url)
  end
  
  def timeline(options)
    
    options = HashWithIndifferentAccess.new(options)
    
    if options["list_id"]
      url = "/1/#{login}/lists/#{options["list_id"]}/statuses.json"
    elsif options["screen_name"]
      url = "/statuses/user_timeline/#{options["screen_name"]}.json"
    else
      url = "/statuses/home_timeline.json"
    end
    
    url << "?#{options.to_query}" unless options.empty?
    
    puts "TWITTER: Getting URL: #{url}"
        
    # tweets = File.open("#{RAILS_ROOT}/db/test_tweets.yml") { |file| YAML.load(file) }
    # tweets.first["text"] = url
    # return tweets          
    twitter.get(url)

  end
  
end

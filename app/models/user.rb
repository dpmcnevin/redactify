class User < TwitterAuth::GenericUser

  has_many :spoilers
    
  def update_test_data
    if RAILS_ENV == "development"
      yaml = twitter.get("/statuses/home_timeline.json").to_yaml
      File.open("#{RAILS_ROOT}/db/test_tweets.yml", "w") { |file| file << yaml }
    end
  end
  
  def spoiler_free_timeline(options = {})
        
    timeline(options).map do |tweet|
      if spoiler?(tweet["text"])
        Redacted.new(tweet,spoiled_on(tweet["text"]))
      else
        Tweet.new(tweet)
      end
    end
  end
  
  def get_tweet(id)
    Tweet.new(twitter.get("/statuses/show/#{id}.json"))
  end
  
  def rate_limit_status
    twitter.get("http://twitter.com/account/rate_limit_status.json")
  end
  
  def spoiler?(tweet)
    spoilers.each do |spoiler|
      return true if tweet =~ /#{spoiler.name}/i
    end
    return false
  end
  
  def spoiled_on(tweet)
    spoilers.reject {|spoiler| tweet !~ /#{spoiler.name}/i}
  end
  
  def popular_tags
    my_spoilers = spoilers.collect(&:name)
    conditions = []
    conditions = ["name NOT IN (?)", my_spoilers] unless my_spoilers.empty?
    
    Spoiler.find(:all, 
      :select => "*,count(*) as count", 
      :conditions => conditions, 
      :order => "count DESC",
      :limit => 5,
      :group => :name)
  end
  
  private
  
  def timeline(options)
    
    if RAILS_ENV == "production"
      if options[:page] && options[:page] =~ /^\d+$/
        url = "/statuses/home_timeline.json?page=#{options[:page]}"
      else
        url = "/statuses/home_timeline.json"
      end
      twitter.get(url)
    else
      ## test data so I don't keep pulling from twitter
      YAML::load_file "#{RAILS_ROOT}/db/test_tweets.yml"
    end
  end
  
end

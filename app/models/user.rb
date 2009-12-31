class User < TwitterAuth::GenericUser

  has_many :spoilers
    
  def update_test_data
    # tweets
    yaml = twitter.get("/statuses/home_timeline.json").to_yaml
    File.open("#{RAILS_ROOT}/db/test_tweets.yml", "w") { |file| file << yaml }
    
    #listst
    yaml = twitter.get("/1/#{login}/lists.json").to_yaml
    File.open("#{RAILS_ROOT}/db/test_lists.yml", "w") { |file| file << yaml }
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
  
  def get_lists
    if RAILS_ENV == "production"
      twitter.get("/1/#{login}/lists.json")
    else
      YAML::load_file "#{RAILS_ROOT}/db/test_lists.yml"  
    end
  end
  
  def get_tweet(id)
    Tweet.new(twitter.get("/statuses/show/#{id}.json"))
  end
  
  def rate_limit_status
    twitter.get("http://twitter.com/account/rate_limit_status.json")
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
  
  private
  
  def timeline(options)
    
    if RAILS_ENV == "production"
      if options["page"] && options["page"] =~ /^\d+$/
        url = "/statuses/home_timeline.json?page=#{options["page"]}"
      elsif options["list_id"]
        url = "/1/#{login}/lists/#{options["list_id"]}/statuses.json"
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

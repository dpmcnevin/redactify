class User < TwitterAuth::GenericUser

  has_many :spoilers

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
    twitter.get("/1/#{login}/lists.json")
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
  
  def post_tweet(tweet)
    if tweet.length <= 140
      twitter.post('/statuses/update.json', 'status' => tweet)
    else
      errors.add("tweet", "Status update over 140 characters")
    end
  end
  
  private
  
  def timeline(options)
    
    if options["list_id"]
      url = "/1/#{login}/lists/#{options["list_id"]}/statuses.json"
    elsif options["screen_name"]
      url = "/statuses/user_timeline/#{options["screen_name"]}.json"
    else
      url = "/statuses/home_timeline.json"
    end

    url << "?page=#{options["page"]}" if options["page"] && options["page"] =~ /^\d+$/
            
    twitter.get(url)

  end
  
end

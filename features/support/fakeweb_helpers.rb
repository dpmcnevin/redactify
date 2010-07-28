FakeWeb.allow_net_connect = false
FakeWeb.register_uri(:post, 'http://twitter.com/oauth/request_token', :body => 'oauth_token=fake&oauth_token_secret=fake')
FakeWeb.register_uri(:post, 'http://twitter.com/oauth/access_token', :body => 'oauth_token=fake&oauth_token_secret=fake')
FakeWeb.register_uri(:get, 'http://twitter.com/account/verify_credentials.json', :response => File.join(Rails.root, "features", "twitter_response", 'verify_credentials.json'))
FakeWeb.register_uri(:get, "http://search.twitter.com/trends.json",  :body => File.join(Rails.root, "features", "twitter_response", "trends.json"))
FakeWeb.register_uri(:get, "http://twitter.com/statuses/home_timeline.json?page=1", :body => File.join(Rails.root, "features", "twitter_response", "timeline-1.json"))
FakeWeb.register_uri(:get, "http://twitter.com/account/rate_limit_status.json", :body => File.join(Rails.root, "features", "twitter_response", "rate_limit_status.json"))
FakeWeb.register_uri(:get, "http://twitter.com/statuses/show/19541735238.json", :body => File.join(Rails.root, "features", "twitter_response", "19541735238.json"))
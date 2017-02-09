# Sample Usage As of Today

```ruby
require File.expand_path('../lib/shadebot.rb',__FILE__)

positive_vibes_handler = ShadeBot::TweetHandler.new do |config|
  config.select_filter = Proc.new do |tweet|
    tweet.text =~ /happy|awesome|fun/i
  end

  config.trigger = Proc.new do |tweet, client, handler|
    puts(tweet.shadebot_to_s)
  end
  
  # This option also exists but has not context for this handler
  config.data = nil
end

client = ShadeBot::TwitterClient.new do |config|
  config.consumer_key         = "SECRET..."
  config.consumer_secret      = "SECRET..."
  config.access_token         = "SECRET..."
  config.access_token_secret  = "SECRET..."

  # filters can be passed here as to Twitter::StreamClient, 
  # an empty filter like this all tweets...
  config.stream_filter        = {} 
end

s.sample_stream do |obj|
  if obj.kind_of? Twitter::Tweet
    generic_tweet_handler.handle(obj,client)
  end
end
```

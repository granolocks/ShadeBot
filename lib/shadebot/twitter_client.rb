
module ShadeBot
  class TwitterClient < Struct.new(
    :consumer_key, :consumer_secret,
    :access_token, :access_token_secret,
    :stream_filter
  )
    def initialize(&block)
      yield(self)

      [ :consumer_key, :consumer_secret,
        :access_token, :access_token_secret ].each do |required_attribute|
        unless self.send(required_attribute)
          raise "ShadeBot::TwitterClient config missing #{required_attribute}".red
          exit 1
        end
      end

      return self
    end

    def send_tweet(tweet, opts={})
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = consumer_key
        config.consumer_secret     = consumer_secret
        config.access_token        = access_token
        config.access_token_secret = access_token_secret
      end

      client.update(tweet, opts)
    end

    def sample_stream(&block)
      loop do
        streaming_client = Twitter::Streaming::Client.new do |config|
          config.consumer_key        = consumer_key
          config.consumer_secret     = consumer_secret
          config.access_token        = access_token
          config.access_token_secret = access_token_secret
        end

        begin
          if stream_filter
            streaming_client.filter(stream_filter, &block)
          else
            streaming_client.sample(&block)
          end
        rescue EOFError
          print "Streaming socket closed restarting socket in "

          [3,2,1].each do |c|
            print " #{c} "
            sleep 0.25
            3.times { print "."; sleep 0.25}
          end

          print "\n"
        end
      end
    end
  end
end

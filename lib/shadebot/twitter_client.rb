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
        end
      end

      return self
    end

    def build_client(type)
      klass = case type
              when :streaming
                Twitter::Streaming::Client
              when :rest
                Twitter::REST::Client
              else
                raise "Invalid client type"
              end

      return klass.new do |config|
        config.consumer_key        = consumer_key
        config.consumer_secret     = consumer_secret
        config.access_token        = access_token
        config.access_token_secret = access_token_secret
      end
    end

    def send_tweet(tweet, opts={})
      build_client(:rest).update(tweet, opts)
    end

    def sample_stream(&block)
      loop do
        streaming_client = build_client(:streaming)

        begin
          client_strategy = stream_filter ? :filter         : :sample
          client_args     = stream_filter ? [stream_filter] : []

          unless block_given?
            block = Proc.new do |obj|
              if obj.kind_of? Twitter::Tweet
                HandlerManager.handle_tweet(obj, build_client(:rest))
              end
            end
          end

          streaming_client.send(client_strategy, *client_args, &block)
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

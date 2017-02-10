module ShadeBot
  module HandlerManager

    @@handlers = []

    def register_handler(h)
      @@handlers.push(h)
    end

    def handle_tweet(tweet, rest_client)
      return false if @@handlers.empty?

      @@handlers.each do |handler|
        handler.handle(tweet, rest_client)
      end

      return true
    end

    module_function :register_handler, :handle_tweet
  end
end

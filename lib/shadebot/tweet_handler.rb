module ShadeBot
  class TweetHandler < Struct.new( :select_filter, :trigger, :data )
    def initialize(&block)
      yield(self)
      return self
    end

    def handle(tweet, rest_client)
      if select_filter.call(tweet)
        trigger.call(tweet,rest_client,self)
      end
    end
  end
end

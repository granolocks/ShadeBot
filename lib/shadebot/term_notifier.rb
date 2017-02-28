module ShadeBot
  module TermNotifier
    def term_width
      `tput cols`.chomp.to_i rescue nil
    end

    def timestamp
      [
        "[#{ Time.now.strftime('%Y-%m-%d %H:%M:%S') }]",
        [:yellow]
      ]
    end

    # expect:
    #   [
    #     ['INFO', [:background_purple, :yellow]],
    #     ['msg_body', [:green]]
    #   ]
    def print_formatted_action(msg, opts={})
      m = [self.timestamp] + msg

      unless opts[:no_truncate]
        if m.map(&:first).join(' ').length > self.term_width
          fixed_length = m[0,2].map(&:first).join(' ').length
          m[2][0] = m[2][0][0,(term_width - fixed_length - 4)] + ' … '
        end
      end

      o = []
      m.each_with_index do |e,i|
        val, colors = e
        colors.each do |c|
          val = val.send c
        end
        o << val
      end

      puts o.join ' '
    end

    def action(action, msg)
      self.print_formatted_action([
        [" #{action} ", [:upcase, :background_purple, :bold_white]],
        [msg, [:green]]
      ])
    end

    def info(msg)
      self.print_formatted_action([
        [" info ", [:upcase, :background_yellow, :bold_white]],
        [msg, [:yellow]]
      ])
    end

    def error(msg)
      self.print_formatted_action([
        [" error ", [:upcase, :background_red, :bold_white]],
        [msg, [:red]]
      ])
    end

    def happy(msg)
      self.print_formatted_action([
        [
          " ..oO0 💖 0Oo.. ",
          [:upcase, :background_cyan, :bold_red ]],
        [msg, [:cyan]]
      ])
    end

    def retweet(tweet)
      text = no_newlines(tweet.text)
      self.action('retweeting', "@#{tweet.user.screen_name}: #{text}")
    end

    def observe(tweet)
      text = no_newlines(tweet.text)

      action = " <o> "

      pre_gen_body = [self.timestamp, action, text]

      if pre_gen_body.join(' ').length > term_width
        body = tweet.shadebot_colorize(text[0,(term_width - pre_gen_body[0,2].join(' ').length - 4)] +
          ' … ')
      else
        # hack
        body = tweet.shadebot_colorize(text)
      end

      self.print_formatted_action([
        [action, [:upcase, :background_black, :green]],
        [body , []]
      ], no_truncate: true)
    end

    module_function :action, :info, :error, :term_width, :happy, :retweet,
      :print_formatted_action, :timestamp, :observe
  end
end

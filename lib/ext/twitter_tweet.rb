module Twitter
  class Tweet
    def shadebot_colorize(line,opts={})
      if opts[:nocolor]
        return line
      else
        line.split(" ").map do |word|
          if 0 == (word =~ /\.?@/)
            word.blue
          elsif 0 == (word =~ /^http/)
            word.underline_purple
          elsif 0 == (word =~ /#/)
            word.yellow
          else
            word
          end
        end.join(" ")
      end
    end

    def shadebot_format(opts={})
      lines = text.split("\n")

      out = []
      lines.each_with_index do |line, i|
        mention_color = if opts[:highlight] && opts[:highlight].include?(user.id.to_i)
                          :background_red
                        else
                          if lines.count > 1
                            :green
                          else
                            :cyan
                          end
                        end # shorten from 'https://twitter.com/username/status/234812038408234'
        # can be manually rehydrated if i want to follow up
        username = url.to_s.gsub('https://twitter.com/','').gsub('/status/', ' ')
        uname_string =  "@#{username}(#{retweet? ? 'y' : 'n'})"
        unless opts[:nocolor]
          uname_string = uname_string.send(mention_color)
        end

        out << uname_string + " #{shadebot_colorize(line, opts)}"

      end
      return out
    end

    def shadebot_to_s(opts={})
      shadebot_format(opts).join("\n")
    end
  end
end

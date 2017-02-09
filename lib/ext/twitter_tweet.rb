module Twitter
  class Tweet
    def shadebot_colorize(line)
      line.split(" ").map do |word|
        if 0 == (word =~ /\.?@/)
          word.blue
        else
          word
        end
      end.join(" ")
    end

    def shadebot_format
      lines = text.split("\n")

      out = []
      lines.each_with_index do |line, i|
        out << if lines.count > 1
                 "@#{user.screen_name} (#{i+1}):".green + " #{shadebot_colorize(line)}"
               else
                 "@#{user.screen_name} (#{i+1}):".red + " #{shadebot_colorize(line)}"
               end

      end
      return out
    end

    def shadebot_to_s
      shadebot_format.join("\n")
    end
  end
end

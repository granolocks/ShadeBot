# Add colorization support to the Core String class
class String
  # colorization
  def colorize(color_code)
    if $stdout.isatty
      "\e[#{color_code}m#{self}\e[0m"
    else
      self
    end
  end

  def color_map
    {
      :black  => "0;30", # Black  - Regular
      :red    => "0;31", # Red    - Regular
      :green  => "0;32", # Green  - Regular
      :yellow => "0;33", # Yellow - Regular
      :blue   => "0;34", # Blue   - Regular
      :purple => "0;35", # Purple - Regular
      :cyan   => "0;36", # Cyan   - Regular
      :white  => "0;37", # White  - Regular

      :bold_black  => "1;30", # Black - Bold
      :bold_red    => "1;31", # Red   - Bold
      :bold_green  => "1;32", # Green - Bold
      :bold_yellow => "1;33", # Yellow- Bold
      :bold_blue   => "1;34", # Blue  - Bold
      :bold_purple => "1;35", # Purple- Bold
      :bold_cyan   => "1;36", # Cyan  - Bold
      :bold_white  => "1;37", # White - Bold

      :underline_black  => "4;30", # Black      - Underline
      :underline_red    => "4;31", # Red        - Underline
      :underline_green  => "4;32", # Green      - Underline
      :underline_yellow => "4;33", # Yellow     - Underline
      :underline_blue   => "4;34", # Blue       - Underline
      :underline_purple => "4;35", # Purple     - Underline
      :underline_cyan   => "4;36", # Cyan       - Underline
      :underline_white  => "4;37", # White      - Underline

      :background_black  => "40",   # Black      - Background
      :background_red    => "41",   # Red        - Background
      :background_green  => "42",   # Green      - Background
      :background_yellow => "43",   # Yellow     - Background
      :background_blue   => "44",   # Blue       - Background
      :background_purple => "45",   # Purple     - Background
      :background_cyan   => "46",   # Cyan       - Background
      :background_white  => "47",   # White      - Background
    }
  end

   def method_missing(name, *args, &block)
     if color_code = color_map[name]
       colorize(color_code)
     else
       super(name, args, block)
     end
   end
end

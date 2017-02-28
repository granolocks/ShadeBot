require 'yaml'
module ShadeBot
  module Config
    CONFIG_FILE = File.expand_path('./../../../config.yml',__FILE__)

    if File.exists?(CONFIG_FILE)
      @@config = YAML.load(File.read(CONFIG_FILE))
    else
      puts "Missing config file! Please place config at #{CONFIG_FILE}".red
      exit!(1)
    end

    def [](key)
      @@config[key]
    end

    def expose
      @@config
    end

    module_function :[], :expose
  end
end

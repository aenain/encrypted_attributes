require "mongoid"

Mongoid.configure do |config|
  raw_config = YAML.load(File.read("config/mongoid.yml"))
  config.sessions = raw_config["test"]["sessions"]
end
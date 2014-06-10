require "sqlite3"
require "active_record"

ActiveRecord::Base.configurations = YAML.load(File.read("config/database.yml"))
ActiveRecord::Base.establish_connection(:test)
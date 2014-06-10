# Excerpt from https://github.com/janko-m/sinatra-activerecord/blob/master/lib/sinatra/activerecord/tasks.rake
load "active_record/railties/databases.rake"
require "sqlite3"

ActiveRecord::Base.configurations = YAML.load(File.read("config/database.yml"))

ActiveRecord::Tasks::DatabaseTasks.tap do |config|
  config.root                   = Rake.application.original_dir
  config.env                    = "test"
  config.db_dir                 = "db"
  config.migrations_paths       = ["db/migrate"]
  config.database_configuration = ActiveRecord::Base.configurations
end

namespace :db do
  task :environment do
    ActiveRecord::Base.establish_connection(:test)
  end
end
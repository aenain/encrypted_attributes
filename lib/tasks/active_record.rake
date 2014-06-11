# Excerpt from https://github.com/janko-m/sinatra-activerecord/blob/master/lib/sinatra/activerecord/tasks.rake
require "active_record"
require "sqlite3"

load "active_record/railties/databases.rake"

ActiveRecord::Base.configurations = YAML.load_file("config/database.yml")

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
$LOAD_PATH.unshift(File.join(__dir__, "..", "lib"))
Dir[File.join(__dir__, "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
end
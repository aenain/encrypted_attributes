module EncryptAttributes
  module Adapters
  end
end

require "encrypt_attributes/adapters/base"
Dir[File.join(__dir__, 'adapters', '*.rb')].each { |adapter| require adapter }
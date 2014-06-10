module EncryptedAttributes
  module Adapters
  end
end

require "encrypted_attributes/adapters/base"
Dir[File.join(__dir__, 'adapters', '*.rb')].each { |adapter| require adapter }
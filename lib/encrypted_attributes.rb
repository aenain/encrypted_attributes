require "active_support/core_ext/object/try"

module EncryptedAttributes
  class MissingAdapterError < StandardError; end

  module_function

  def find_adapter(base)
    adapter = adapters.find do |receiver, adapter|
      base.ancestors.map(&:to_s).include?(receiver)
    end.try(:last)

    adapter || (raise MissingAdapterError)
  end

  def register_adapter(receiver, adapter)
    adapters[receiver] = adapter
  end

  def adapters
    @adapters ||= {}
  end
end

require "encrypted_attributes/version"
require "encrypted_attributes/macros"
require "encrypted_attributes/encryptor"
require "encrypted_attributes/model"
require "encrypted_attributes/adapters"
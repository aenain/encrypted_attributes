require "active_support/core_ext/object/try"

module EncryptAttributes
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

require "encrypt_attributes/version"
require "encrypt_attributes/macros"
require "encrypt_attributes/encryptor"
require "encrypt_attributes/model"
require "encrypt_attributes/adapters"
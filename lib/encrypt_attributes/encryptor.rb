require "active_support/core_ext/module/attribute_accessors"
require "active_support/message_encryptor"
require "encrypt_attributes"

module EncryptAttributes
  class Encryptor
    cattr_accessor :secret

    if defined?(Rails)
      self.secret ||= Rails.application.secrets.secret_key_base
    end

    def encrypt(value)
      return value if value.to_s.empty?
      message_encryptor.encrypt_and_sign(value)
    end

    def decrypt(value)
      return value if value.to_s.empty?
      message_encryptor.decrypt_and_verify(value)
    end

    def message_encryptor
      ActiveSupport::MessageEncryptor.new(self.class.secret)
    end
  end
end
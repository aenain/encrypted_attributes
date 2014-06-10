module EncryptedAttributes
  module Adapters
    module Base
      def read_encrypted_attribute(attr_name)
        encryptor.decrypt(read_attribute(attr_name))
      end

      def write_encrypted_attribute(attr_name, attr_value)
        write_attribute(attr_name, encryptor.encrypt(attr_value))
      end

      private

      def encryptor
        Encryptor.new
      end
    end
  end
end
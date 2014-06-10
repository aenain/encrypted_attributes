require "encrypted_attributes"

module EncryptedAttributes
  module Model
    def self.included(base)
      base.class_eval do
        include EncryptedAttributes.find_adapter(base)
      end
      base.extend(Macros)
    end
  end
end
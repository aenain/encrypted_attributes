require "encrypt_attributes"

module EncryptAttributes
  module Model
    def self.included(base)
      base.class_eval do
        include EncryptAttributes.find_adapter(base)
      end
      base.extend(Macros)
    end
  end
end
module EncryptedAttributes
  module Adapters
    module Mongoid
      include Base
    end
  end

  self.register_adapter("Mongoid::Document",
    EncryptedAttributes::Adapters::Mongoid)
end
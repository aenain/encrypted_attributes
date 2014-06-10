module EncryptedAttributes
  module Adapters
    module ActiveRecord
      include Base
    end
  end

  self.register_adapter("ActiveRecord::Base",
    EncryptedAttributes::Adapters::ActiveRecord)
end
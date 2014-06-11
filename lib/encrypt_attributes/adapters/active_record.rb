module EncryptAttributes
  module Adapters
    module ActiveRecord
      include Base
    end
  end

  self.register_adapter("ActiveRecord::Base",
    EncryptAttributes::Adapters::ActiveRecord)
end
module EncryptAttributes
  module Adapters
    module Mongoid
      include Base
    end
  end

  self.register_adapter("Mongoid::Document",
    EncryptAttributes::Adapters::Mongoid)
end
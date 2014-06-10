require "spec_helper"
require "support/connections/mongoid"

require "encrypted_attributes/model"

class MongoidUser
  include Mongoid::Document
  include EncryptedAttributes::Model

  field :secret, type: String

  encrypt_attrs :secret
end unless defined?(MongoidUser)

describe MongoidUser do
  after(:all) { Mongoid.purge! }
  include_examples "adapter"
end
require "spec_helper"
require "support/connections/mongoid"

require "encrypt_attributes/model"

class MongoidUser
  include Mongoid::Document
  include EncryptAttributes::Model

  field :secret, type: String

  encrypt_attrs :secret
end unless defined?(MongoidUser)

describe MongoidUser do
  after(:all) { Mongoid.purge! }
  include_examples "adapter"
end
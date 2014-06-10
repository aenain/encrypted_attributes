require "spec_helper"
require "support/connections/active_record"

require "encrypted_attributes/model"

class User < ActiveRecord::Base
  include EncryptedAttributes::Model
  encrypt_attrs :secret
end unless defined?(User)

describe User do
  after(:all) { User.delete_all }
  include_examples "adapter"
end
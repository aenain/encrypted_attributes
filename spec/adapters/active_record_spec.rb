require "spec_helper"
require "support/connections/active_record"

require "encrypt_attributes/model"

class User < ActiveRecord::Base
  include EncryptAttributes::Model
  encrypt_attrs :secret
end unless defined?(User)

describe User do
  after(:all) { User.delete_all }
  include_examples "adapter"
end
# EncryptedAttributes

This gem provides a dead-simple encryption of string / text attributes of ActiveRecord and Mongoid models.  Encryptor internally uses [ActiveSupport::MessageEncryptor](http://api.rubyonrails.org/classes/ActiveSupport/MessageEncryptor.html) and therefore it uses 'aes-256-cbc' cipher by default. Currently there is no way to pass custom options to the encryptor. Gem does NOT require column with different name. It works just fine without it, but works only with columns of type `string` or `text`. From user perspective encryption is completely transparent - they use decrypted values all the time, but encrypted values are stored in database.

## ORM Support

Integration with ActiveRecord and Mongoid has been tested. Other frameworks should work as expected if they provide `#read_attribute` and `#write_attribute` methods. They are supposed to work in similar way as in ActiveRecord.

## Recommendations

Provided functionality is sufficient for storing oauth tokens and secrets that are not to be searched for. If you are looking for something more sophisticated, then check out my recommendations below.

[attr_encrypted](https://github.com/attr-encrypted/attr_encrypted) extends `Object`, so it works with any Ruby class, but requires an encrypted attribute to have a different name than the regular one.

[CryptKepper](http://jmazzi.github.io/crypt_keeper/) is a perfect solution if you need to search through encrypted fields, but supports ActiveRecord only.

[symmetric-encryption](https://github.com/reidmorrison/symmetric-encryption) is based on RSA-encrypted keys and supports ActiveRecord, MongoMapper and Mongoid. It provides type coercion and can be used to secure configuration files as well. PCI compliant.

## Installation

Add this line to your application's Gemfile:

    gem 'encrypted_attributes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install encrypted_attributes

## Usage

Provide a secret for `Encryptor`. Create a model with fields of type `string` or `text`, include `EncryptedAttributes::Model` and call `encrypt_attrs(*attrs)`.

### Secret

If you are using Rails, secret by default will be set to `Rails.application.secrets.secret_key_base`. If you want to use a different secret, create an initializer:

    # config/initializers/encrypted_attributes.rb
    EncryptedAttributes::Encryptor.secret = "<super-secure-key>"

If you do not use Rails, set the secret before any encryption is done, otherwise an error will be thrown.

* ActiveRecord

    # db/migrate/create_authentications.rb
    class CreateAuthentication < ActiveRecord::Migration
      def change
        create_table :authentications, force: true do |t|
          t.string :token
          t.string :secret
        end
      end
    end

    # app/models/authentication.rb
    class Authentication < ActiveRecord::Base
      include EncryptedAttributes::Model
      encrypt_attrs :token, :secret
    end

* Mongoid

    # app/models/authentication.rb
    class Authentication
      include Mongoid::Document
      # it is important to include Mongoid::Document before
      include EncryptedAttributes::Model

      field :token,  type: String
      field :secret, type: String

      encrypt_attrs :token, :secret
    end

## Custom accessors

If you want to define custom accessors for encrypted attributes, create methods you need to override and call `super` to execute encryption / decryption. It will work the same way with all supported ORMs.

    # app/models/authentication.rb
    class Authentication < ActiveRecord::Base
      include EncryptedAttributes::Model
      encrypt_attrs :token, :secret

      def secret
        super.tap do |decrypted|
          # do whatever you want here
        end
      end

      def secret=(new_secret)
        super
        # do whatever you want here
      end
    end

## Gotchas

Beware that each time encryption is done it returns a different value for the same input argument. Check out the consequences on the example below.

    user = User.create(secret: "secret")
    user.secret = "secret" # the same value
    user.secret_changed? # returns true

ORMs will think that the secret has changed, because after setting a value, it gets encoded and a new value is stored in `attributes`.

## Running tests

    bundle exec rspec

## Contributing

1. Fork it ( https://github.com/aenain/encrypted_attributes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

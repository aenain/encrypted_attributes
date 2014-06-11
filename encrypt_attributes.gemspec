ENV["RACK_ENV"] ||= "test"

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'encrypt_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "encrypt_attributes"
  spec.version       = EncryptAttributes::VERSION
  spec.authors       = ["Artur Hebda"]
  spec.email         = ["arturhebda@gmail.com"]
  spec.summary       = "Dead-simple attributes encryption for ORMs"
  spec.description   = "This gem provides a dead-simple encryption of string / text attributes of ActiveRecord and Mongoid models. Encryptor internally uses ActiveSupport::MessageEncryptor and therefore it uses 'aes-256-cbc' cipher by default. Gem does NOT require column with different name. From user perspective encryption is completely transparent - they use decrypted values all the time, but encrypted values are stored in database."
  spec.homepage      = "https://github.com/aenain/encrypted_attributes"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 4.1"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0.rc1"
  spec.add_development_dependency "rspec-mocks", "~> 3.0.0.rc1"

  spec.add_development_dependency "activerecord", ">= 4.1"
  spec.add_development_dependency "mongoid", "~> 4.0.0.beta1"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "pry-byebug"
end

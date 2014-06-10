ENV["RACK_ENV"] ||= "test"

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'encrypted_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = "encrypted_attributes"
  spec.version       = EncryptedAttributes::VERSION
  spec.authors       = ["Artur Hebda"]
  spec.email         = ["arturhebda@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
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

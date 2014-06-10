RSpec::Matchers.define :be_encryption_of do |expected|
  match do |actual|
    begin
      secret    = EncryptedAttributes::Encryptor.secret
      encryptor = ActiveSupport::MessageEncryptor.new(secret)
      encryptor.decrypt_and_verify(actual) == expected
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      false
    end
  end

  failure_message do |actual|
    "expected that #{actual} would be an encryption of #{expected}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not be an encryption of #{expected}"
  end

  description do
    "be an encryption of #{expected}"
  end
end
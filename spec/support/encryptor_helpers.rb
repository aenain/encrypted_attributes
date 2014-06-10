module EncryptorHelpers
  VALID_SECRET = "14a678aa4a78286d94878d2256f6e591b53707b3f1ec9cdd4cbfde1514670d32".freeze

  def self.included(base)
    base.class_eval do
      let(:decrypted) { "decrypted" }
      let(:encrypted) { encrypt(decrypted) }
    end
  end

  def encrypt(value)
    encryptor = EncryptedAttributes::Encryptor.new
    encryptor.class.secret ||= VALID_SECRET
    encryptor.encrypt(value)
  end
end
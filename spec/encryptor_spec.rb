require "spec_helper"
require "encrypted_attributes/encryptor"

def set_valid_encryptor_secret
  EncryptedAttributes::Encryptor.secret = EncryptorHelpers::VALID_SECRET
end

describe EncryptedAttributes::Encryptor do
  include MessageEncryptorHelpers

  it { should respond_to(:secret) }
  it { should respond_to(:secret=) }

  describe "#message_encryptor" do
    let(:secret) { "secret" }
    let(:encryptor_class) { ActiveSupport::MessageEncryptor }

    it "uses secret to instantiate encryptor" do
      described_class.secret = secret
      allow(encryptor_class).to receive(:new)
      described_class.new.message_encryptor
      expect(encryptor_class).to have_received(:new).with(secret)
    end
  end

  describe "#encrypt" do
    subject { described_class.new }

    before(:each) do
      set_valid_encryptor_secret
    end

    context "nil" do
      it "returns nil" do
        expect(subject.encrypt(nil)).to be_nil
      end
    end

    context "empty string" do
      it "returns empty string" do
        expect(subject.encrypt("")).to eq ""
      end
    end

    context "not empty value" do
      let(:decrypted) { "decrypted" }

      it "encrypts correctly" do
        expect(subject.encrypt(decrypted))
          .to be_encryption_of(decrypted)
      end
    end
  end

  describe "#decrypt" do
    subject { described_class.new }

    before(:each) do
      set_valid_encryptor_secret
    end

    context "nil" do
      it "returns nil" do
        expect(subject.decrypt(nil)).to be_nil
      end
    end

    context "empty string" do
      it "returns empty string" do
        expect(subject.decrypt("")).to eq ""
      end
    end

    context "not empty value" do
      let(:decrypted) { "decrypted" }
      let(:encrypted) { subject.encrypt(decrypted) }

      it "decrypts correctly" do
        expect(subject.decrypt(encrypted)).to eq decrypted
      end
    end

    context "tampered value" do
      it "raises error" do
        expect {
          subject.decrypt("tampered")
        }.to raise_error(ActiveSupport::MessageVerifier::InvalidSignature)
      end
    end
  end
end
shared_examples_for "adapter:storing" do
  subject { described_class.new }

  describe "storing" do
    it "encrypts attributes" do
      subject.secret = decrypted
      subject.save

      expect(read_attribute.call(:secret)).to eq encrypted
    end
  end
end

shared_examples_for "adapter:retrieving" do
  subject { described_class.create(secret: decrypted) }

  describe "retrieving" do
    it "decrypts specified attributes" do
      subject.reload
      expect(subject.secret).to eq decrypted
    end
  end
end

shared_examples_for "adapter:overrides:reader" do
  subject { described_class.create(secret: decrypted) }

  describe "overriden reader" do
    it "supports super chain" do
      def subject.secret
        super.tap { |v| yield v if block_given? }
      end

      injection = double(call: nil)
      subject.secret { |v| injection.call(v) }

      expect(injection).to have_received(:call).with(decrypted)
    end
  end
end

shared_examples_for "adapter:overrides:writer" do
  subject { described_class.create(secret: decrypted) }

  describe "overriden writer" do
    let(:injection) { double(call: nil) }

    before(:each) do
      subject.instance_variable_set(:@injection, injection)
      def subject.secret=(new_secret)
        @injection.call
        super
      end
    end

    it "supports super chain" do
      subject.secret = decrypted
      subject.save

      expect(injection).to have_received(:call)
      expect(read_attribute.call(:secret)).to eq encrypted
    end
  end
end

shared_examples_for "adapter" do
  include EncryptorHelpers

  let(:read_attribute) { subject.public_method(:read_attribute) }
  let(:encryptor) { double(encrypt: encrypted, decrypt: decrypted) }

  before(:each) do
    allow(EncryptAttributes::Encryptor)
      .to receive(:new).and_return(encryptor)
  end

  include_examples "adapter:storing"
  include_examples "adapter:retrieving"
  include_examples "adapter:overrides:reader"
  include_examples "adapter:overrides:writer"
end
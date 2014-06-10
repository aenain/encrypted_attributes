module MessageEncryptorHelpers
  def stub_message_encryption(input, output)
    allow_any_instance_of(ActiveSupport::MessageEncryptor)
      .to receive(:encrypt_and_sign).with(input)
        .and_return(output)
  end

  def stub_message_decryption(input, output)
    allow_any_instance_of(ActiveSupport::MessageEncryptor)
      .to receive(:decrypt_and_verify).with(input)
        .and_return(output)
  end
end
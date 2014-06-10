module EncryptedAttributes
  module Macros
    def encrypt_attrs(*attr_names)
      mod = Module.new
      mod.module_eval do
        attr_names.each do |attr_name|
          # getter
          define_method(attr_name) do
            read_encrypted_attribute(attr_name)
          end

          # setter
          define_method("#{attr_name}=") do |value|
            write_encrypted_attribute(attr_name, value)
          end
        end
      end
      include mod
    end
  end
end
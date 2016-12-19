module OpenSslKeys
  def openssl_private_key_path
    File.join(File.dirname(__FILE__), '../', 'example_files', 'test_key.pem')
  end

  def openssl_public_key_path
    File.join(File.dirname(__FILE__), '../', 'example_files', 'test_cert.pem')
  end
end

RSpec.configure do |config|
  config.include OpenSslKeys
end

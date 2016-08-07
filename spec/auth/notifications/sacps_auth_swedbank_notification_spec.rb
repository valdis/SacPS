# rspec spec/auth/notifications/sacps_auth_swedbank_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Swedbank::Notification do
  context "validation" do
    before :all do
      Mock::Auth::Swedbank.public_key = File.read(File.expand_path("spec/example_files/mock_swedbank_server_cert.pem"))
      Mock::Auth::Swedbank.private_key = File.read(File.expand_path("spec/example_files/mock_swedbank_server_key.pem"))
      valid_http_raw_data = Mock::Auth::Swedbank::NotificationGenerator.new.build_raw_response
      invalid_http_raw_data = Mock::Auth::Swedbank::NotificationGenerator.new.invalidate_field('VK_NONCE').build_raw_response

      SacPS::Auth::Swedbank.bank_public_key = File.read(File.expand_path("spec/example_files/mock_swedbank_server_cert.pem"))
      @valid_notification = SacPS::Auth::Swedbank.notification valid_http_raw_data
      @invalid_notification = SacPS::Auth::Swedbank.notification invalid_http_raw_data
    end

    it "should use a valid key pair for encryption and decryption" do
      plaintext_mock_swedbank_server_cert = File.read(File.expand_path("spec/example_files/mock_swedbank_server_cert.pem"))
      plaintext_mock_swedbank_server_key = File.read(File.expand_path("spec/example_files/mock_swedbank_server_key.pem"))
      message = "i am message"
      mock_swedbank_server_public_key = OpenSSL::X509::Certificate.new(plaintext_mock_swedbank_server_cert.gsub(/  /, '')).public_key
      mock_swedbank_server_private_key = OpenSSL::PKey::RSA.new(plaintext_mock_swedbank_server_key.gsub(/  /, ''))
      digest = OpenSSL::Digest::SHA1.new

      #sign
      signature = mock_swedbank_server_private_key.sign(digest, message)
      #verify signature
      is_valid = mock_swedbank_server_public_key.verify(digest, signature, message)

      expect(is_valid).to eq true
    end

    it "valid? should return true form_fields are authentic" do
      expect(@valid_notification.valid?).to eq true
    end

    it "valid? should return false if any of fields arent authentic" do
      expect(@invalid_notification.valid?).to eq false
    end
  end

  context "data" do
    before :all do
      valid_http_raw_data = "VK_SERVICE=3003&VK_VERSION=008&VK_SND_ID=TEST&VK_REC_ID=TEST&VK_NONCE=25254142330344004260105519515191011979668867223483&VK_INFO=PERSON:050505-12123;NAME:JOHN DOE&VK_MAC=LyCZRncu%2F%2BOi5nwzOkI6C9UMFohN6tSl3tLFyIJyNp2lGKBrDKZ2H8b%2BadU3XalzS7MwnAj8r%2FRhLpbsGNE5ysNyM4CKkSrsVzxoXbt9%2BB1foH9Rlp9LCeoR2H774f8UcMe9RVsE%2B%2BZfrEZzzXYyR1PXDCVOShQOAxlD9pbh8nk%3D&VK_LANG=LAT&VL_ENCODING=UTF-8"
      @valid_notification = SacPS::Auth::Swedbank.notification valid_http_raw_data
    end

    it "should return correct user user_information" do
      expect(@valid_notification.user_information).to eq "050505-12123;JOHN DOE"
    end

    it "should return correct user name" do
      expect(@valid_notification.user_name).to eq "JOHN DOE"
    end

    it "should return correct user identifier" do
      expect(@valid_notification.user_identifier).to eq "050505-12123"
    end

    it "should return correct user language" do
      expect(@valid_notification.user_language).to eq "lv"
    end
  end

  private

  # swedbank responds to our authentication request with an encrypted notification,
  # that is encrypted the same way our authentication request is.
  # To test this we pretend to be the bank and use a self generated key pair to sign
  # and verify the notification
  # the keys used for test purpases are in spec/expample_files and can be generated
  # by calling
  # openssl req  -nodes -new -x509 -keyout swedbank_test_key.pem -out swedbank_test_cert.pem -days 3650
  def generate_notification
    service_msg_number =
    sigparams =
    requried_service_params =
    SacPS::Auth::Banklink.generate_signature(service_msg_number, sigparams, required_service_params)
  end

end

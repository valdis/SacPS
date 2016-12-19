# rspec spec/auth/notifications/sacps_auth_dnb_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Dnb::Notification do
  let(:http_raw_data) { "VK_SERVICE=2001&VK_VERSION=101&VK_SND_ID=RAND&VK_REC_ID=ACC1&VK_STAMP=12345678910&VK_T_NO=123456789012&VK_PER_CODE=050505-12123&VK_PER_FNAME=JOHN&VK_PER_LNAME=DOE&VK_COM_NAME=Company&VK_TIME=20131111111111&VK_LANG=LAT" }
  let(:valid_notification) do
    params = TestCrypt.to_params(http_raw_data)
    params['VK_MAC'] = TestCrypt.new(private_key_path: openssl_private_key_path)
      .generate_signature_param(params, SacPS::Auth::Dnb.required_service_params[2001])
    SacPS::Auth::Dnb.notification TestCrypt.to_query(params)
  end
  let(:invalid_notification) do
    params = TestCrypt.to_params(http_raw_data)
    params['VK_MAC'] = 'invalid'
    SacPS::Auth::Dnb.notification TestCrypt.to_query(params)
  end

  before :all do
    SacPS::Auth::Dnb.public_key = File.read(openssl_public_key_path)
    SacPS::Auth::Dnb.private_key = File.read(openssl_private_key_path)
    SacPS::Auth::Dnb.bank_public_key = File.read(openssl_public_key_path)
  end

  it "should return correct user user_information" do
    expect(valid_notification.user_information).to eq "050505-12123;JOHN DOE"
  end

  it "should return correct user name" do
    expect(valid_notification.user_name).to eq "JOHN DOE"
  end

  it "should return correct user identifier" do
    expect(valid_notification.user_identifier).to eq "050505-12123"
  end

  it "should return correct user language" do
    expect(valid_notification.user_language).to eq "lv"
  end

  it "valid? should return true form_fields are authentic" do
    expect(valid_notification.valid?).to eq true
  end

  it "valid? should return false if any of fields arent authentic" do
    expect(invalid_notification.valid?).to eq false
  end
end

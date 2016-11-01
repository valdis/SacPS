# rspec spec/auth/notifications/sacps_auth_seb_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Seb::Notification do
  let(:valid_http_raw_data) { "IB_SND_ID=ACC1&IB_SERVICE=0001&IB_REC_ID=AAA&IB_USER=050505-12123&IB_DATE=05.12.2003&IB_TIME=10:00:00&IB_USER_INFO=ID=050505-12123;NAME=JOHN DOE&IB_VERSION=001&IB_CRC=LyCZRncu%2F%2BOi5nwzOkI6C9UMFohN6tSl3tLFyIJyNp2lGKBrDKZ2H8b%2BadU3XalzS7MwnAj8r%2FRhLpbsGNE5ysNyM4CKkSrsVzxoXbt9%2BB1foH9Rlp9LCeoR2H774f8UcMe9RVsE%2B%2BZfrEZzzXYyR1PXDCVOShQOAxlD9pbh8nk%3D&IB_LANG=LAT" }
  let(:valid_notification) do
    params = TestCrypt.to_params(valid_http_raw_data)
    params['IB_CRC'] = generate_ib_crc(params, required_fields)
    SacPS::Auth::Seb.notification TestCrypt.to_query(params)
  end
  let(:invalid_notification) do
    params = TestCrypt.to_params(valid_http_raw_data)
    params['IB_CRC'] = 'invalid'
    SacPS::Auth::Seb.notification TestCrypt.to_query(params)
  end

  before :all do
    SacPS::Auth::Seb.public_key = File.read(openssl_public_key_path)
    SacPS::Auth::Seb.private_key = File.read(openssl_private_key_path)
    SacPS::Auth::Seb.bank_public_key = File.read(openssl_public_key_path)
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

  def generate_ib_crc(params, required_fields)
    CGI.escape(TestCrypt.new(private_key_path: openssl_private_key_path)
      .calc_mac_signature(params, required_fields))
  end

  def required_fields
    SacPS::Auth::Seb.required_service_params['0005']
  end


end

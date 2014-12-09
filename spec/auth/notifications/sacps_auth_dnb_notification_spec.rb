# rspec spec/auth/notifications/sacps_auth_dnb_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Dnb::Notification do
  before :all do
    valid_http_raw_data = "VK_SERVICE=2001&VK_VERSION=101&VK_SND_ID=RAND&VK_REC_ID=ACC1&VK_STAMP=12345678910&VK_T_NO=123456789012&VK_PER_CODE=050505-12123&VK_PER_FNAME=JOHN&VK_PER_LNAME=DOE&VK_COM_NAME=Company&VK_TIME=20131111111111&VK_LANG=LAT"
    @valid_notification = SacPS::Auth::Dnb.notification valid_http_raw_data
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

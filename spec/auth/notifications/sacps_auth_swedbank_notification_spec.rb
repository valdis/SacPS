# rspec spec/auth/notifications/sacps_auth_swedbank_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Swedbank::Notification do
  before :all do
    VALID_HTTP_RAW_DATA = "VK_SERVICE=3003&VK_VERSION=008&VK_SND_ID=TEST&VK_REC_ID=TEST&VK_NONCE=25254142330344004260105519515191011979668867223483&VK_INFO=PERSON:050505-12123;NAME:JOHN DOE&VK_MAC=LyCZRncu%2F%2BOi5nwzOkI6C9UMFohN6tSl3tLFyIJyNp2lGKBrDKZ2H8b%2BadU3XalzS7MwnAj8r%2FRhLpbsGNE5ysNyM4CKkSrsVzxoXbt9%2BB1foH9Rlp9LCeoR2H774f8UcMe9RVsE%2B%2BZfrEZzzXYyR1PXDCVOShQOAxlD9pbh8nk%3D&VK_LANG=LAT&VL_ENCODING=UTF-8"
    @valid_notification = SacPS::Auth::Swedbank.notification VALID_HTTP_RAW_DATA
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


# # encoding: utf-8

# require File.dirname(__FILE__) + '/test_helper'

# class SacPSAuthSwedbankNotificationtest < Minitest::Test
#   # include Banklink

#   def setup
#     @swedbank_auth = SacPS::Auth::Swedbank.notification(http_raw_data)
#   end

#   def test_user_information
#     assert_equal "050505-12123;JOHN DOE", @swedbank_auth.user_information
#   end

#   def test_user_name
#     assert_equal "JOHN DOE", @swedbank_auth.user_name
#   end

#   def test_user_identifier
#     assert_equal "050505-12123", @swedbank_auth.user_identifier
#   end

#   def test_user_language
#     assert_equal "lv", @swedbank_auth.user_language
#   end

#   private
#     def http_raw_data
#       "VK_SERVICE=3003&VK_VERSION=008&VK_SND_ID=TEST&VK_REC_ID=TEST&VK_NONCE=25254142330344004260105519515191011979668867223483&VK_INFO=PERSON:050505-12123;NAME:JOHN DOE&VK_MAC=LyCZRncu%2F%2BOi5nwzOkI6C9UMFohN6tSl3tLFyIJyNp2lGKBrDKZ2H8b%2BadU3XalzS7MwnAj8r%2FRhLpbsGNE5ysNyM4CKkSrsVzxoXbt9%2BB1foH9Rlp9LCeoR2H774f8UcMe9RVsE%2B%2BZfrEZzzXYyR1PXDCVOShQOAxlD9pbh8nk%3D&VK_LANG=LAT&VL_ENCODING=UTF-8"
#     end

# end

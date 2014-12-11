# rspec spec/auth/notifications/sacps_auth_swedbank_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Swedbank::Notification do
  context "validation" do
    before :all do
      valid_http_raw_data =   "VK_SERVICE=3003&VK_VERSION=008&VK_SND_ID=HP&VK_REC_ID=REFEREND&VK_NONCE=48064728456631139890576881998733355098303532232665&VK_INFO=ISIK:160992-10610;NIMI:KRISTIĀNS PURVIŅŠ&VK_ENCODING=UTF-8&VK_MAC=BdTGaM90+aSDAVDfHFooTFEUlkdqxCWpr+Vxn6SkKj27mJyllqQP9Hxqw+PfYUhUUsDbqHIUN95qPl9t9aabn+caIbdcMq6aHbqNBoc7svhlNv0qBse8NaNIp7xnwjPVDzZA4ExyBvlRMGmrsSNbjc2P9SkdSWDfxgwb3GEPkoE="
      invalid_http_raw_data = "VK_SERVICE=3003&VK_VERSION=008&VK_SND_ID=HP&VK_REC_ID=REFEREND&VK_NONCE=63244166086213189956175700685245263586579875921384&VK_INFO=ISIK:123456-10312;NIMI:MĀRIS CUKURS&VK_ENCODING=UTF-8&VK_MAC=S+Gt91E1I9WEL/qIWOgOUJB0h4WDeBHrfETqC4UG9Xe58YOP30iIRoMJOlBSHvfswVWEuSwCbBVsWIQt7tqHsY1IbidEsJ2ffdkCgofO9qPDBTuS9CI3bbPhK3gMtxkFs5BzxmXEu4bJHvuVJF40g4HyFZe3ozrUem2BHQS6u0Y="
      @invalid_http_raw_data = SacPS::Auth::Swedbank.notification invalid_http_raw_data
      @valid_notification = SacPS::Auth::Swedbank.notification valid_http_raw_data
    end
  
    it "valid? should return true form_fields are authentic" do
      expect(@valid_notification.valid?).to eq true
    end

    it "valid? should return false if any of fields arent authentic" do
      expect(@valid_notification.valid?).to eq false
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

end

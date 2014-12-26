# rspec spec/auth/notifications/sacps_auth_nordea_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Nordea::Notification do
  context "validation" do
    before :all do
      valid_http_raw_data = "B02K_VERS=0002&B02K_TIMESTMP=2002014122613494481&B02K_IDNBR=618644&B02K_STAMP=20141226134943110341&B02K_CUSTNAME=%C4%B6esteris+%C4%A2irts&B02K_KEYVERS=0001&B02K_ALG=01&B02K_CUSTID=12345612345&B02K_CUSTTYPE=01&B02K_MAC=58C05531FB7706C79BAFBFCB21A43C33"
      invalid_http_raw_data = "B02K_VERS=0002&B02K_TIMESTMP=2002014122613494481&B02K_IDNBR=618644&B02K_STAMP=20141226134943110341&B02K_CUSTNAME=%C4%B6esteris+%C4%A2irts&B02K_KEYVERS=0001&B02K_ALG=01&B02K_CUSTID=65432112345&B02K_CUSTTYPE=01&B02K_MAC=58C05531FB7706C79BAFBFCB21A43C33"
      @invalid_http_raw_data = SacPS::Auth::Nordea.notification invalid_http_raw_data
      @valid_notification = SacPS::Auth::Nordea.notification valid_http_raw_data
    end
  
    it "valid? should return true form_fields are authentic" do
      expect(@valid_notification.valid?).to eq true
    end

    it "valid? should return false if any of fields arent authentic" do
      expect(@invalid_http_raw_data.valid?).to eq false
    end
  end

  context "fields" do
    before :all do
      valid_http_raw_data = "B02K_VERS=0002&B02K_TIMESTMP=2002014110314171455&B02K_IDNBR=618644&B02K_STAMP=20141103141713056838&B02K_CUSTNAME=Doe+John&B02K_KEYVERS=0001&B02K_ALG=01&B02K_CUSTID=05050512123&B02K_CUSTTYPE=01&B02K_MAC=F788CDFAB29BEDA3D9AE3EAA73E06258"
      @valid_notification = SacPS::Auth::Nordea.notification valid_http_raw_data
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
  end
end

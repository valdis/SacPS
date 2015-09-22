# rspec spec/auth/notifications/sacps_auth_citadele_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Citadele::Notification do
  before :each do
    @time = Time.use_zone('Riga'){ Time.zone.parse("2015-06-01 2pm") }
    Timecop.freeze(@time)

    @valid_notification = SacPS::Auth::Citadele.notification SacPS::Auth::Citadele::Notification.test_response.strip
    now = (Time.now - 60.seconds).strftime("%Y%m%d%H%M%S%3N")
    @valid_notification.response_hash["Timestamp"] = now
  end

  it "should be frozen at the correct time" do
    expect(Time.now).to eq "2015-06-01 14:00:00 +0300".to_datetime
  end

  it "should return correct verification status" do
    expect(@valid_notification.valid?).to eq true
  end

  describe "Initialization" do
    it "should return correct user user_information" do
      expect(@valid_notification.user_information).to eq "290479-12576;AŠĶŪO TestDP"
    end

    it "should return correct user pers code" do
      expect(@valid_notification.user_identifier).to eq "290479-12576"
    end

    it "should return correct user name" do
      expect(@valid_notification.user_name).to eq "AŠĶŪO TestDP"
    end

    it "should return correct user bank" do
      expect(@valid_notification.from).to eq "CITADELE"
    end

    it "should return correct uuid" do
      expect(@valid_notification.uuid).to eq "11cd235b-1010-48ea-ad54-5c7c93f0e3ba"
    end
  end

  describe "Code" do
    it "should TRUE if code is 100" do
      expect(@valid_notification.code).to eq '100'
      expect(@valid_notification.code_ok?).to eq true
    end
    it "should raise AuthenticationCancelledError if code is 200" do
      @valid_notification.code = "200"
      expect { @valid_notification.code_ok? }.to raise_error(/AuthenticationCancelledError/)
    end
    it "should raise AuthenticationCancelledError if code is 300" do
      @valid_notification.code = "300"
      expect { @valid_notification.code_ok? }.to raise_error
    end
  end

  describe "Signature" do
    it "should TRUE if signature is ok" do
      #binding.pry
      expect(@valid_notification.signature_ok?).to eq true
    end
    it "should throw an error if response xml is fed backwards" do
      @valid_notification.xml = @valid_notification.xml.reverse
      expect { @valid_notification.signature_ok? }.to raise_error
    end
    it "should raise InvalidXMLSignatureError if signature gets edited" do
      halves = @valid_notification.xml.split("<SignatureValue>")
      second_half = halves.last
      second_half[4] = (second_half[4] == "Q" ? "R" : "Q")
      new_halves =[]
      new_halves << halves.first
      new_halves << second_half
      new_halves = new_halves.join("<SignatureValue>")
      expect(@valid_notification.xml).not_to eq new_halves

      @valid_notification.xml = new_halves

      expect { @valid_notification.signature_ok? }.to raise_error(/InvalidXMLSignatureError/)
    end
    it "should raise InvalidXMLSignatureError if data gets edited" do
      halves = @valid_notification.xml.split("<RequestUID>")
      second_half = halves.last
      second_half[4] = (second_half[4] == "Q" ? "R" : "Q")
      new_halves =[]
      new_halves << halves.first
      new_halves << second_half
      new_halves = new_halves.join("<RequestUID>")
      expect(@valid_notification.xml).not_to eq new_halves

      @valid_notification.xml = new_halves

      expect { @valid_notification.signature_ok? }.to raise_error(/InvalidXMLSignatureError/)
    end
  end

  describe "Timestamp" do
    it "should TRUE timestamp if within 15 minutes" do
      now = (Time.now - 1.second).strftime("%Y%m%d%H%M%S")
      @valid_notification.response_hash["Timestamp"] = now
      expect(@valid_notification.timestamp_ok?).to eq true

      now = (Time.now - 899.seconds).strftime("%Y%m%d%H%M%S")
      @valid_notification.response_hash["Timestamp"] = now
      expect(@valid_notification.timestamp_ok?).to eq true
    end
    it "should raise error if stamp is newer than now" do
      now = (Time.now + 160.seconds).strftime("%Y%m%d%H%M%S%3N")
      @valid_notification.response_hash["Timestamp"] = now
      expect { @valid_notification.timestamp_ok? }.to raise_error(/RequestExpiredError/)
    end
    it "should raise error if stamp is older than 900s" do
      now = (Time.now - 900.seconds).strftime("%Y%m%d%H%M%S")
      @valid_notification.response_hash["Timestamp"] = now
      expect { @valid_notification.timestamp_ok? }.to raise_error(/RequestExpiredError/)
    end
  end

  describe "Request type" do
    it "should TRUE if type is AUTHRESP" do
      expect(@valid_notification.request_type_ok?).to eq true
    end
  end

end

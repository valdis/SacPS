# rspec spec/auth/notifications/sacps_auth_citadele_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Seb::Notification do
  let(:valid_notification) { SacPS::Auth::Citadele.notification TEST_CITADELE_RESPONSE.strip }

  SacPS::Auth::Citadele.return_url = "http://lvh.me:3000/auth/citadele"

  describe "Initialization" do
    it "should return correct user user_information" do
      expect(valid_notification.user_information).to eq "010101-12345;JĀNIS BĒRZIŅŠ"
    end

    it "should return correct user pers code" do
      expect(valid_notification.user_identifier).to eq "010101-12345"
    end

    it "should return correct user name" do
      expect(valid_notification.user_name).to eq "JĀNIS BĒRZIŅŠ"
    end

    it "should return correct user bank" do
      expect(valid_notification.from).to eq "CITADELE"
    end

    it "should return correct uuid" do
      expect(valid_notification.uuid).to eq "68a434e6-1763-7b3c-7b64-d0f327738334"
    end

    it "should extract the signature correctly" do
      expect(valid_notification.response_hash["SignatureValue"]).to eq "GFzAo2U5fY..."
    end

    it "should extract the cert correctly" do
      expect(valid_notification.response_hash["SignatureCert"].strip).to eq SacPS::Auth::Citadele.public_key.strip
    end
  end

  describe "Code" do
    it "should TRUE if code is 100" do
      expect(valid_notification.code_ok?).to eq true
    end

    it "should FALSE if code is not 100" do
      valid_notification.code = "200"
      expect(valid_notification.code_ok?).to eq false
    end
  end

  describe "Cert" do
    it "should TRUE if certs match" do
      expect(valid_notification.cert_ok?).to eq true
    end
    it "should FALSE if certs are different" do
      SacPS::Auth::Citadele.public_key.freeze
      pubkey = ""
      pubkey += SacPS::Auth::Citadele.public_key
      pubkey[28] = "Q"
      valid_notification.response_hash["SignatureCert"] = pubkey
      expect(valid_notification.cert_ok?).to eq false
    end
  end

  describe "Signature" do
    xit "should TRUE if valid signature" do
      expect(valid_notification).to eq 1
    end
    xit "should FALSE if signature malformed" do
      expect(valid_notification).to eq 1
    end
  end

  describe "Timestamp" do
    it "should TRUE timestamp if within 15 minutes" do
      now = (Time.now - 60.seconds).strftime("%Y%m%d%H%M%S%3N")
      valid_notification.response_hash["Timestamp"] = now
      expect(valid_notification.timestamp_ok?).to eq true
    end
    it "should FALSE timestamp if stamp is newer than now" do
      now = (Time.now + 160.seconds).strftime("%Y%m%d%H%M%S%3N")
      valid_notification.response_hash["Timestamp"] = now
      expect(valid_notification.timestamp_ok?).to eq false
    end
    it "should FALSE timestamp if stamp is older than 900s" do
      now = (Time.now - 900.seconds).strftime("%Y%m%d%H%M%S%3N")
      valid_notification.response_hash["Timestamp"] = now
      expect(valid_notification.timestamp_ok?).to eq false
    end
  end

  it "should return correct verification status" do
    now = (Time.now - 60.seconds).strftime("%Y%m%d%H%M%S%3N")
    valid_notification.response_hash["Timestamp"] = now
    expect(valid_notification.ok?).to eq true
  end


end

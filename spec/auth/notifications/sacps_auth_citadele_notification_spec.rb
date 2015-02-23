# rspec spec/auth/notifications/sacps_auth_citadele_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Seb::Notification do
  let(:valid_notification) { SacPS::Auth::Citadele.notification TEST_CITADELE_RESPONSE.strip }

  SacPS::Auth::Citadele.return_url = "http://lvh.me:3000/auth/citadele"
  SacPS::Auth::Citadele.identifier = "13091" # Your merchant number with Citadele

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

  it "should check the signature" do
    puts ENV['DDD']
    expect(valid_notification.signature?).to eq 1
  end

  # it "should TRUE timestamp if within 15 minutes" do
  #   now = Time.now.strftime("%Y%m%d%H%M%S%3N")
  #   pr valid_notification.response_hash["Timestamp"]
  #   valid_notification.response_hash["Timestamp"] = now
  #   pr valid_notification.response_hash["Timestamp"]
  #   expect(valid_notification.timestamp_ok?).to eq 1
  # end

  # it "should FALSE timestamp if outside 15 minutes" do
  #   expect(valid_notification.timestamp_ok?).to eq "CITADELE"
  # end

  it "should TRUE if code is 100" do
    expect(valid_notification.code_ok?).to eq true
  end

  it "should FALSE if code is not 100" do
    valid_notification.code = "200"
    expect(valid_notification.code_ok?).to eq false
  end

  xit "should return correct verification status" do
    expect(valid_notification.code_ok?).to eq true
    expect(valid_notification.ok?).to eq true # set to true if passes
  end


end

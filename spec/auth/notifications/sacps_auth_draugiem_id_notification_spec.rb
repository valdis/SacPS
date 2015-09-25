# rspec spec/auth/notifications/sacps_auth_draugiem_id_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::DraugiemId::Notification do
  let(:notification) { SacPS::Auth::DraugiemId::Notification.new("1") }

  describe ".perform_complete_stack!(dr_auth_code)" do
    it "can not and is not specced, cuz uses production urls" do
      expect(1).to eq 1
    end
  end

  describe "initialization" do
    it "initializes with given 'dr_auth_code'" do
      expect(notification.dr_auth_code).to eq "1"
    end
  end

  describe "#authorize!" do
    it "raises error if called without dr_auth_code" do
      expect {notification.authorize!}.to raise_error RuntimeError
    end
  end

  describe "#parse_user_data!" do
    it "should raise specific runtime error" do
      notification.auth_response = TEST::AUTH_RESPONSE_WITHOUT_PK
      expect{ notification.parse_user_data! }.to raise_error(SacPS::Auth::DraugiemId::NotificationError, /pk_missing/)
    end

    it "sets @user_identifier correctly" do
      notification.auth_response = TEST::AUTH_RESPONSE_WITH_PK
      notification.parse_user_data!
      expect(notification.user_identifier ).to eq "123456-12345"
    end

    it "sets @user_name correctly" do
      notification.auth_response = TEST::AUTH_RESPONSE_WITH_PK
      notification.parse_user_data!
      expect(notification.user_name ).to eq "Jānis Bērziņš"
    end
  end

end

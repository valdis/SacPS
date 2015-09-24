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

  describe "#parse_user_data!" do
    let(:hash) { {
      "users" => {
        "3342174" => {
          "uid" => 3342174,
          "name" => "J\u0101nis",
          "surname" => "B\u0113rzi\u0146\u0161",
          "url" => "\/beerzinjanis\/",
          "emailHash" => "a21e7e99b3c11a755e7835901c2ec0c2",
          "place" => "R\u012bga",
          "nick" => "Janka",
          "age" => 21,
          "adult" => 1,
          "sex"=>"M",
          "created"=>"01.01.2005 11:32:55",
          "deleted"=>false,
          "pk"=>"123456-12345"
        }
      }
    } }

    it "sets @user_identifier correctly" do
      notification.user_data_response = hash      
      notification.parse_user_data!
      expect(notification.user_identifier ).to eq "123456-12345"
    end

    it "sets @user_name correctly" do
      notification.user_data_response = hash
      notification.parse_user_data!
      expect(notification.user_name ).to eq "Jānis Bērziņš"
    end
  end

end

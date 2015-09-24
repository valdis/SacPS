# rspec spec/auth/helpers/sacps_auth_draugiem_id_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::DraugiemId::Helper do
  before :all do
    @helper = SacPS::Auth::DraugiemId.helper
  end

  describe "initialization" do
    it "should have @authentication_url" do
      # pr @helper.authentication_url
      expect(@helper.authentication_url.present?).to eq true
    end
  end

  describe "#build_authentication_url" do
    it "should match the format in documentation" do
      # Autorizācijas lapas saites adrese veidojas šādā formā: https://api.draugiem.lv/authorize/?app=[aplikācijas_id]&hash=[kontroles_kods]&redirect=[pāradresācijas_adrese]
      match_regex = /https\:\/\/api\.draugiem\.lv\/authorize\/\?app\=(.*?)\&hash\=(.*?)\&redirect\=(.*?)/
      expect(@helper.build_authentication_url[match_regex].present?).to eq true
    end
  end

  describe "#build_control_code" do
    it "returns the 32 digit MD5 hash" do
      expect(@helper.build_control_code.size).to eq 32
    end
  end


end

# rspec spec/auth/helpers/sacps_auth_citadele_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Citadele::Helper do

  let(:helper) { SacPS::Auth::Citadele.helper }

  it "should initialize helper with no arguments" do
    SacPS::Auth::Citadele.validate_config
    puts helper.xml.gsub(/\n/, '').gsub(/\>\s+\</, '><')
    expect(helper.present?).to eq true
  end

  it "should return correct identifier" do
    expect(helper.identifier).to eq ENV["CITADELE_IDENTIFIER"]
  end

  it "should initialize with an unique_identifier" do
    puts uuid = helper.uuid
    expect(uuid.present?).to eq true
    expect(uuid.size).to eq 36
  end

  it "should return correct return_url" do
    expect(helper.return_url).to eq 'http://lvh.me:3000/auth/citadele'
  end

  # rspec spec/auth/helpers/sacps_auth_citadele_helper_spec.rb:28
  it "should make valid xml" do
    array = helper.xml.split("\n")
    expect(array[3]).to include "Timestamp"
  end

  it "should create correct amount of fields" do
    expect(helper.form_fields.size).to eq 1
  end

  it "should create correct digest" do
    expect(helper.digest.size).to be > 20
    expect(helper.digest.last).to eq "="
  end

  it "should create correct signed_info xml element block" do
    array = helper.signed_info.split("\n")
    expect(array[8].strip).to match(/\<DigestValue\>.*\=\<\/DigestValue\>/)
  end

  it "should create correct signature" do
    expect(helper.signature.last).to eq "="
  end

  it "signature should verify" do
    helper_instance = helper
    decoded_ignature = Base64.decode64(helper_instance.signature)
    state = SacPS::Auth::Citadele.get_private_key.public_key.verify(OpenSSL::Digest::SHA1.new, decoded_ignature, helper_instance.signed_info)

    expect(state).to eq true
  end




end

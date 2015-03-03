# rspec spec/auth/helpers/sacps_auth_citadele_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Citadele::Helper do

  let(:helper) { SacPS::Auth::Citadele.helper }

  it "should initialize helper with no arguments" do
    SacPS::Auth::Citadele.validate_config!
    puts helper.xml
    expect(helper.present?).to eq true
  end

  it "should return correct identifier" do
    expect(helper.identifier).to eq ENV["CITADELE_IDENTIFIER"]
  end

  it "should initialize with an unique_identifier" do
    expect(helper.uuid.present?).to eq true
    expect(helper.uuid.size).to eq 36
  end

  it "should return correct return_url" do
    expect(helper.return_url).to eq 'http://lvh.me:3000/auth/citadele'
  end

  it "should create correct amount of fields" do
    expect(helper.form_fields.size).to eq 1
  end

  it "should create correct digest" do
    digest = helper.xml.match(/(?<=<DigestValue>).*?(?=<\/DigestValue>)/).to_s
    expect(digest.size).to be > 20
    expect(digest.last).to eq "="
  end

  it "should create correct signed_info xml element block" do
    signature = helper.xml.match(/(?<=<SignatureValue>)(\n|.)*?(?=<\/SignatureValue>)/).to_s
    expect(signature.size).to be > 650
    expect(signature.last).to eq "="
  end

end
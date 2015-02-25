# rspec spec/auth/helpers/sacps_auth_citadele_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Citadele::Helper do

  let(:helper) { SacPS::Auth::Citadele.helper }

  it "should initialize helper with no arguments" do
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
    puts helper.xml#.gsub(/\>\s+\</, '><').gsub(/\n/, '')
    expect(array[3]).to include "Timestamp"
  end

  it "should create correct amount of fields" do
    expect(helper.form_fields.size).to eq 1
  end


end

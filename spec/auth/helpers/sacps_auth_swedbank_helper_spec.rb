# rspec spec/auth/helpers/sacps_auth_swedbank_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Swedbank::Helper do
  before :all do
    @helper = SacPS::Auth::Swedbank.helper
  end

  it "should create correct amount of fields" do
    expect(@helper.form_fields.size).to eq 9
  end
end
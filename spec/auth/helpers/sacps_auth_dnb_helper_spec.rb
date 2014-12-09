# rspec spec/auth/helpers/sacps_auth_dnb_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Dnb::Helper do
  before :all do
    @helper = SacPS::Auth::Dnb.helper
  end

  it "should create correct amount of fields" do
    expect(@helper.form_fields.size).to eq 7
  end
end

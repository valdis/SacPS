# rspec spec/auth/helpers/sacps_auth_nordea_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Nordea::Helper do
  before :all do
    @helper = SacPS::Auth::Nordea.helper
  end

  it "should create correct amount of fields" do
    expect(@helper.form_fields.size).to eq 12
  end
end

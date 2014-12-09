# rspec spec/auth/helpers/sacps_auth_seb_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Seb::Helper do
  before :all do
    @helper = SacPS::Auth::Seb.helper
  end

  it "should create correct amount of fields" do
    expect(@helper.form_fields.size).to eq 3
  end
end

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


# # encoding: utf-8

# require File.dirname(__FILE__) + '/test_helper'

# class SacPSAuthSwedbankHelperTest < Minitest::Test
#   def test_should_create_fields
    
#     helper = SacPS::Auth::Swedbank.helper
#     assert_equal 9, helper.form_fields.size
#   end

# end

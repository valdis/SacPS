# rspec spec/tests/auth_common_spec.rb

require 'spec_helper'

describe "AuthCommon" do
  include SacPS::Auth::Common

  it "" do
    expect(func_p("ĀĒŪĪĻĶŠ")).to eq "007"
  end

  it "" do 
    expect((generate_random_string 50).size).to eq 50
  end
end
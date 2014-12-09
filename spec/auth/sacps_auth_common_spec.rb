# rspec spec/auth/sacps_auth_common_spec.rb

require 'spec_helper'

describe SacPS::Auth::Common do
  include SacPS::Auth::Common

  it "should return length of string represented as string of three integers" do
    expect(func_p("ĀĒŪĪĻĶŠ")).to eq "007"
  end

  it "generate_random_string should return as many chars as passed to method" do 
    expect((generate_random_string 50).size).to eq 50
  end
end
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

  describe String do
    describe "#strip_crypto_wrappers" do
      it "removes first and last line from certs" do
        cert = File.read("#{SacPS.root}/spec/example_files/example_cert")
        expect(cert.strip_crypto_wrappers).to eq "T2SORfoV1nTeQZLfVHYPvjIi8KL0KzDsJn6gaP3ApZiF+BKwZZmO/8X8ICPJKdwS"
      end
      it "removes nothing from clean cert strings" do
        cert = File.read("#{SacPS.root}/spec/example_files/example_cert")
        expect(cert.strip_crypto_wrappers.strip_crypto_wrappers).to eq cert.strip_crypto_wrappers
      end
    end
  end
end

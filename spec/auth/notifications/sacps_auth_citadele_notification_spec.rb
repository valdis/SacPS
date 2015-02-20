# rspec spec/auth/notifications/sacps_auth_citadele_notification_spec.rb

require 'spec_helper'

describe SacPS::Auth::Seb::Notification do
  before :all do
    responnse_xml = <<-EOF
<?xml version="1.0" encoding="UTF-8" ?>
<FIDAVISTA xmlns="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1
  http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1/fidavista.xsd">
  <Header>
    <Timestamp>20081101175959000</Timestamp>
    <From>10001</From>
    <Extension>
      <Amai xmlns="http://online.citadele.lv/XMLSchemas/amai/"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://online.citadele.lv/XMLSchemas/amai/
      http://online.citadele.lv/XMLSchemas/amai/amai.xsd">
        <Request> AUTHRESP</Request>
        <RequestUID>7387bf5b-fa27-4fdd-add6-a6bfb2599f77</RequestUID>
        <Version>3.0</Version>
        <Language>LV</Language>
        <PersonCode>01010112345</PersonCode>
        <Person>BĒRZIŅŠ JĀNIS</Person>
        <Code>100</Code>
        <Message>placeholder</Message>
        <SignatureData>
        <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
r2tul4LmC/m7TrsF4KVbs9RNo4j9IVBSz57NRIN7HlSne+2yodnpffizQVEX
rh/W/nZTR0yLhrXXlEVZBB1ghEFIu5V4rSs3Q8Odycylci20WCmPLyxWa3oY
/z3oSaR1fDI4I89v63isToZrhoCXJed4L5PRTMkLhgWyJ19gHTdCFDBVoARA
+iG9nsAnhAdUXg7Nxe+it7r9KNJG6YqExFN+4akJTBf/OqthJkDctQCwy5yf
KoU0Zo79wp2rLQwkWAkbReAhGoEFi53QukFfdWANw+7aWQOdHPYC9BCg/Tor
        </Signature>
        </SignatureData>
      </Amai>
    </Extension>
  </Header>
</FIDAVISTA>
    EOF
    @valid_notification = SacPS::Auth::Citadele.notification responnse_xml
  end

  it "should return correct user user_information" do
    expect(@valid_notification.user_information).to eq "010101-12345;JĀNIS BĒRZIŅŠ"
  end

  it "should return correct user pers code" do
    expect(@valid_notification.user_identifier).to eq "010101-12345"
  end

  it "should return correct user name" do
    expect(@valid_notification.user_name).to eq "JĀNIS BĒRZIŅŠ"
  end

  it "should return correct user bank" do
    expect(@valid_notification.from).to eq "CITADELE"
  end

  # it "should TRUE timestamp if within 15 minutes" do
  #   now = Time.now.strftime("%Y%m%d%H%M%S%3N")
  #   pr @valid_notification.response_hash["Timestamp"]
  #   @valid_notification.response_hash["Timestamp"] = now
  #   pr @valid_notification.response_hash["Timestamp"]
  #   expect(@valid_notification.timestamp_ok?).to eq 1
  # end

  # it "should FALSE timestamp if outside 15 minutes" do
  #   expect(@valid_notification.timestamp_ok?).to eq "CITADELE"
  # end

  it "should TRUE if code is 100" do
    expect(@valid_notification.code_ok?).to eq true
  end

  it "should FALSE if code is not 100" do
    @valid_notification.code = "200"
    expect(@valid_notification.code_ok?).to eq false
  end

  xit "should return correct verification status" do
    expect(@valid_notification.code_ok?).to eq true
    expect(@valid_notification.ok?).to eq true # set to true if passes
  end


end

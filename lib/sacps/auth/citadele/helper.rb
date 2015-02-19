module SacPS
  module Auth
    module Citadele
      class Helper

        include SacPS::Auth::Common
        include SacPS::Auth::Citadele

        attr_accessor :identifier, :return_url, :xml, :form_fields

        def initialize
          @identifier = SacPS::Auth::Citadele.identifier
          @return_url = SacPS::Auth::Citadele.return_url
          @xml = build_request_xml

          @form_fields = { "xmldata" => @xml }
        end

        def sign(unsigned_string)
          rsa         = OpenSSL::PKey::RSA.new(SacPS::Auth::Citadele.private_key)
          signed_hash = rsa.sign(OpenSSL::Digest::SHA1.new, unsigned_string)
          Base64.encode64(signed_hash) # TO-DO: Figure out if this is needed
        end

        def build_request_xml
          timestamp = Time.now.strftime("%Y%m%d%H%M%S%3N") # "20030905175959000"
          unique_id = SecureRandom.uuid # "7387bf5b-fa27-4fdd-add6-a6bfb2599f77"
          request = "AUTHREQ"
          version = "3.0"
          language = "LV"
          signature = sign( [timestamp, @identifier, request, unique_id, version, language, @return_url].join )

          xml = <<-XML
<?xml version="1.0" encoding="UTF-8" ?>
<FIDAVISTA xmlns="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1
http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1/fidavista.xsd">
  <Header>
    <Timestamp>#{timestamp}</Timestamp>
    <From>#{@identifier}</From>
    <Extension>
      <Amai xmlns="http://online.citadele.lv/XMLSchemas/amai/"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://online.citadele.lv/XMLSchemas/amai/
      http://online.citadele.lv/XMLSchemas/amai/amai.xsd">
        <Request>#{request}</Request>
        <RequestUID>#{unique_id}</RequestUID>
        <Version>#{version}</Version>
        <Language>#{language}</Language>
        <ReturnURL>#{@return_url}</ReturnURL>
        <SignatureData>
          <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">\n#{signature}</Signature>
        </SignatureData>
      </Amai>
    </Extension>
  </Header>
</FIDAVISTA>
          XML

          return xml.chomp
        end

      end # -- Class Helper ends
    end
  end
end
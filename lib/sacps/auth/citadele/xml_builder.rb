module SacPS
  module Auth
    module Citadele
      class Helper

        # def sign(unsigned_string)
        #   rsa         = OpenSSL::PKey::RSA.new(SacPS::Auth::Citadele.private_key)
        #   signed_hash = rsa.sign(OpenSSL::Digest::SHA1.new, unsigned_string)
        #   Base64.encode64(signed_hash) # TO-DO: Figure out if this is needed
        # end

        def return_signed_request_xml
          # return build_unsigned_request_xml # TESTING ONLY
          unsigned_document = Xmldsig::SignedDocument.new(build_unsigned_request_xml)
          return unsigned_document.sign(SacPS::Auth::Citadele.get_private_key)
        end

        private

          def build_unsigned_request_xml
            timestamp = Time.now.strftime("%Y%m%d%H%M%S%3N") # "20030905175959000"
            request = "AUTHREQ"
            version = "3.0"
            language = "LV"
            ivis_url = "http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1"
            amai_url = "http://online.citadele.lv/XMLSchemas/amai/"
            #signature = sign( [timestamp, @identifier, request, unique_id, version, language, @return_url].join )

            xml = <<-XML
<?xml version="1.0" encoding="UTF-8" ?>
<FIDAVISTA xmlns="#{ivis_url}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="#{ivis_url} #{ivis_url}/fidavista.xsd">
  <Header>
    <Timestamp>#{timestamp}</Timestamp>
    <From>#{@identifier}</From>
    <Extension>
      <Amai xmlns="#{amai_url}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="#{amai_url} #{amai_url}amai.xsd">
        <Request>#{request}</Request>
        <RequestUID>#{@unique_identifier}</RequestUID>
        <Version>#{version}</Version>
        <Language>#{language}</Language>
        <ReturnURL>#{@return_url}</ReturnURL>
      </Amai>
    </Extension>
  </Header>
</FIDAVISTA>
XML
            clean_xml = xml.strip.chomp
            # Raise an error on malformedness
            doc = Nokogiri::XML(clean_xml) { |config| config.strict }
            #puts ">>>>>>> CANON <<<<<<<"
            #puts doc.canonicalize
            return doc.canonicalize # clean_xml
          end

      end
    end
  end
end
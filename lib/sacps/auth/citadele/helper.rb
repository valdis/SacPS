module SacPS
  module Auth
    module Citadele
      class Helper

        include SacPS::Auth::Common
        include SacPS::Auth::Citadele

        attr_accessor :identifier, :return_url, :xml, :form_fields, :unique_identifier

        def initialize
          raise "Citadele cert init failed! See readme." if ENV["CITADELE_IDENTIFIER"].blank? || SacPS::Auth::Citadele.private_key.blank?
          @identifier = SacPS::Auth::Citadele.identifier
          @return_url = SacPS::Auth::Citadele.return_url
          @unique_identifier = SecureRandom.uuid # "7387bf5b-fa27-4fdd-add6-a6bfb2599f77"
          @xml = return_signed_request_xml

          @form_fields = { "xmldata" => @xml }
        end

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
        <SignatureData>
          <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
            <SignedInfo>
              <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
              <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
              <Reference>
                <Transforms>
                  <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
                </Transforms>
                <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
                <DigestValue></DigestValue>
              </Reference>
            </SignedInfo>
            <SignatureValue></SignatureValue>
            <KeyInfo>
              <X509Data>
                <X509Certificate>#{ENV["CITADELE_PRIVATE_CERT"]}</X509Certificate>
              </X509Data>
            </KeyInfo>
          </Signature>
        </SignatureData>
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

      end # -- Class Helper ends
    end
  end
end
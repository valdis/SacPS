module SacPS
  module Auth
    module Citadele
      class Helper

        def return_signed_request_xml
          xml = <<-XML
<?xml version="1.0" encoding="UTF-8" ?>
<FIDAVISTA xmlns="#{@ivis_url}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="#{@ivis_url} #{@ivis_url}/fidavista.xsd">
  <Header>
    <Timestamp>#{@timestamp}</Timestamp>
    <From>#{@identifier}</From>
    <Extension>
      <Amai xmlns="#{@amai_url}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="#{@amai_url} #{@amai_url}amai.xsd">
        <Request>#{@request}</Request>
        <RequestUID>#{@uuid}</RequestUID>
        <Version>#{@version}</Version>
        <Language>#{@language}</Language>
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
                <DigestValue>#{@digest}</DigestValue>
              </Reference>
            </SignedInfo>
            <SignatureValue>#{@signature}</SignatureValue>
            <KeyInfo>
              <X509Data>
                <X509Certificate>#{SacPS::Auth::Citadele.private_cert}</X509Certificate>
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
          doc = Nokogiri::XML(clean_xml) { |config| config.strict }
          return clean_xml #doc.canonicalize

        end


        private

          def build_unsigned_request_xml
            xml = <<-XML
<?xml version="1.0" encoding="UTF-8" ?>
<FIDAVISTA xmlns="#{@ivis_url}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="#{@ivis_url} #{@ivis_url}/fidavista.xsd">
  <Header>
    <Timestamp>#{@timestamp}</Timestamp>
    <From>#{@identifier}</From>
    <Extension>
      <Amai xmlns="#{@amai_url}" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="#{@amai_url} #{@amai_url}amai.xsd">
        <Request>#{@request}</Request>
        <RequestUID>#{@unique_identifier}</RequestUID>
        <Version>#{@version}</Version>
        <Language>#{@language}</Language>
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

          def build_digest
            Base64.encode64( OpenSSL::Digest::SHA1.digest(@unsigned_xml_part) ).strip
          end

          def build_signed_info
            signed_info = <<-XML
<SignedInfo>
  <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
  <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
  <Reference>
    <Transforms>
      <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
    </Transforms>
    <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
    <DigestValue>#{@digest}</DigestValue>
  </Reference>
</SignedInfo>
            XML

            clean_xml = signed_info.strip.chomp
            return Nokogiri::XML(clean_xml) { |config| config.strict }.canonicalize
          end

          def build_signature
                privkey = SacPS::Auth::Citadele.get_private_key
            signed_hash = privkey.sign(OpenSSL::Digest::SHA1.new, @signed_info)
            return Base64.encode64(signed_hash).strip
          end

      end
    end
  end
end
module SacPS
  module Auth
    module Citadele
      class Helper

        def return_signed_request_xml
          unsigned_xml = <<-XML.unindent
          <?xml version="1.0" encoding="UTF-8"?>
          <FIDAVISTA xmlns="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-2 http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-2/fidavista.xsd">
            <Header>
              <Timestamp>#{@timestamp}</Timestamp>
              <From>#{@identifier}</From>
              <Extension>
                <Amai xmlns="http://online.citadele.lv/XMLSchemas/amai/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://online.citadele.lv/XMLSchemas/amai/ http://online.citadele.lv/XMLSchemas/amai/amai.xsd">
                  <Request>#{@request}</Request>
                  <RequestUID>#{@uuid}</RequestUID>
                  <Version>#{@version}</Version>
                  <Language>#{@language}</Language>
                  <Location>#{@location}</Location>
                  <ReturnURL>#{@return_url}</ReturnURL>
                  <SignatureData>
                    <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
                      <SignedInfo>
                        <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
                        <SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"/>
                        <Reference URI="">
                          <Transforms>
                            <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
                          </Transforms>
                          <DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
                          <DigestValue></DigestValue>
                        </Reference>
                      </SignedInfo>
                      <SignatureValue></SignatureValue>
                      <KeyInfo>
                        <X509Data>
                          <X509Certificate>#{SacPS::Auth::Citadele.get_private_cert}</X509Certificate>
                        </X509Data>
                      </KeyInfo>
                    </Signature>
                  </SignatureData>
                </Amai>
              </Extension>
            </Header>
          </FIDAVISTA>
          XML

          unsigned_xml.gsub!("\n", '')
          unsigned_document = Xmldsig::SignedDocument.new(unsigned_xml)
          signed_xml = unsigned_document.sign(SacPS::Auth::Citadele.get_private_key)
          return signed_xml
        end

      end
    end
  end
end

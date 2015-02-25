module SacPS
  module Auth
    module Citadele
      class Notification

        def build_unsigned_response_xml
          return get_response_head + get_response_tail
        end

        def get_response_head
          xml.split("<SignatureData>").first.strip
        end

        def get_response_tail
          xml.split("</SignatureData>").last
        end

        def build_digest
          Base64.encode64( OpenSSL::Digest::SHA1.digest(build_unsigned_response_xml) ).strip
        end

        def self.test_response
          <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<FIDAVISTA xmlns="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1
    http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1/fidavista.xsd">
  <Header>
    <Timestamp>20140502155029000</Timestamp>
    <From>10000</From>
    <Extension>
      <Amai xmlns="http://digi.parex.lv/XMLSchemas/amai/"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://digi.parex.lv/XMLSchemas/amai/
          http://digi.parex.lv/XMLSchemas/amai/amai.xsd">
        <Request>AUTHRESP</Request>
        <RequestUID>68a434e6-1763-7b3c-7b64-d0f327738334</RequestUID>
        <Version>3.0</Version>
        <Language>LV</Language>
        <PersonCode>01010112345</PersonCode>
        <Person>BĒRZIŅŠ JĀNIS</Person>
        <Code>100</Code>
        <SignatureData>
          <Signature xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
            <SignedInfo>
              <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
              <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"/>
              <Reference URI="">
                <Transforms>
                  <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"/>
                </Transforms>
                <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
                <DigestValue>z3BWJmWj1oXqcRkQ55O/hCfMY60=</DigestValue>
              </Reference>
            </SignedInfo>
            <SignatureValue>i+NMuGzrtVGHdYez3v1cbXNkn2cV4hjvS6CpDGeHtSsOf4zVG3x74d2C17AotcAd6TOeMmLw8MaSv4Ug+CeTsuKcODMyAVjjBSsrTWQizRRDTsI2X1bvveATKPbQbdJ8WN6P8IdAhtTnfG49bWaVIYglX4mhpkB3jBkBMBtocn7f7Q6DPGPdQEkWY2VZStIhoi7d7TIkXkLolB8jj2opnJTXT8P3bdvDcTl9ZJ1VhW4X6jYBprXB+3Mbd+RzPNhGaFam7Dat76ZlTzQocnvmJh2ky9CDBZgBtrqej2LclOoX6YTX8yAPpsLyTokIOCHeTZJeSBNl5wml3YWRdTdzwLtVcKdwp0c0uKKmvPUALgA9KjHbYee0xcL0pt0lOwPG/oI59vS3crzcJrknxtNS8DI2otcC7z8AD5CiI79iuk6imLx6uT+hDscWsHiZaPlJ6r9ovMfhqITg+EoIj4gJUEG8sUslRU3v2peQcVh7Iq+tXvXjj7Z8RcCAYgv+H+bnIiK/7SVfRTlDNMoUtfQx9WuaAsHfYTjrvXiD7b0A/QySrWHn/LVaGOz018xyajtc+gzNwLqtX87Z8xceJbssxN0NTnOOkbyPK52gnnYzDMYYkP7FL/CdSwWQByFrepfgZjjZRECJbkVjF5R2akkhj8hMMHIwlvzQhwbvWi3hiCA=</SignatureValue>
            <KeyInfo>
              <X509Data>
              <X509SubjectName>CN=AMAI,OU=BTD,O=ASPAREX BANKA,L=RIGA,ST=Unknown,C=LV</X509SubjectName>
              <X509Certificate>#{SacPS::Auth::Citadele.public_key}</X509Certificate>
              </X509Data>
            </KeyInfo>
          </Signature>
        </SignatureData>
      </Amai>
    </Extension>
  </Header>
</FIDAVISTA>
EOF
        end

      end
    end
  end
end
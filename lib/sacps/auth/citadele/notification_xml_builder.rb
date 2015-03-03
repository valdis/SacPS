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
          <<-EOF.unindent
          <?xml version="1.0" encoding="UTF-8"?>
          <FIDAVISTA xmlns="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1
              http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1/fidavista.xsd">
            <Header>
              <Timestamp>#{Time.now.strftime("%Y%m%d%H%M%S%3N")}</Timestamp>
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

        def self.test_resp2
          <<-EOF.unindent
          <?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<FIDAVISTA xmlns=\"http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1 http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1/fidavista.xsd\"><Header><Timestamp>20150303094523000</Timestamp><From>10000</From><Extension><Amai xmlns=\"http://online.citadele.lv/XMLSchemas/amai/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://online.citadele.lv/XMLSchemas/amai/ http://online.citadele.lv/XMLSchemas/amai/amai.xsd\"><Request>AUTHRESP</Request><RequestUID>11cd235b-1010-48ea-ad54-5c7c93f0e3ba</RequestUID><Version>3.0</Version><Language>LV</Language><PersonCode>29047912576</PersonCode><Person>TestDP AŠĶŪO</Person><Code>100</Code><SignatureData><Signature xmlns=\"http://www.w3.org/2000/09/xmldsig#\"><SignedInfo><CanonicalizationMethod Algorithm=\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\"/><SignatureMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#rsa-sha1\"/><Reference URI=\"\"><Transforms><Transform Algorithm=\"http://www.w3.org/2000/09/xmldsig#enveloped-signature\"/></Transforms><DigestMethod Algorithm=\"http://www.w3.org/2000/09/xmldsig#sha1\"/><DigestValue>1wkn6vNe3+w0RcFDcflC/tmg7Ic=</DigestValue></Reference></SignedInfo><SignatureValue>enVuwwV/kDsk/qssoddAaOiW27rE6sYqmWJ4YHtzECrAvjzczbISkoKpcMlhpGTtin+tjRx/soi6\r\njV1caiLun46D8w3qoU2xeDJB8ISEpXC3jZ2yg/BNUgSPMagNECFrSvmpMRMPxe5KiK0/bxCRCa2p\r\n8M3IZDRprPOtiJRrzXTxhaVTh4Fhc/TKQfe1idJoJ7QeSzWULaN0M6lG/AqPA/zY9kTtNGx6VBxv\r\nvpIp8ES9jVj+HhXGfZYxHe+14ziY2e46+HK7V2YFEEljK1zFiYrRcKcgdA7v35qTGvCikDczQFZj\r\njmV0wmU/TURNvHSG7vkrcRvMKxkx5KEpN1sDztzVyCuyC2eizz29CKyu1xqYislhEFSuK/9n+9iZ\r\nnq05lKW+GG7Ei49GzWIgRB5g19yM0vPH6YuGMINNn7uNv6U5n3HQPwxDYjmFHYEb63H6QiYdkw+A\r\nXf+dG3fGo9hPwaFRUNn8go2p5RpeaKosAaWlhE+aDEnFWLt6dT5QBBnES+mg3FzlHRACO2EI92Rh\r\nOgdDPK2zDawi2FXsyiJM6W8K66+qikbHmJvkqvK/KVlA9BLY/GaEUXH90I6N8YSMarVi4+ofESMj\r\n9a7g0jF7wLqNeJCE2FM+0+BkcIGRAhunXEB+uUm1V6/jwlgNNb+z/2PWPh6ayKdFuwIKCbOmrXM=</SignatureValue><KeyInfo><X509Data><X509SubjectName>CN=AMAI-test,OU=IT,O=Citadele Banka AS,L=Riga,ST=Unknown,C=LV</X509SubjectName><X509Certificate>MIIFdTCCA12gAwIBAgIEWjSIGzANBgkqhkiG9w0BAQsFADBrMQswCQYDVQQGEwJMVjEQMA4GA1UE\r\nCBMHVW5rbm93bjENMAsGA1UEBxMEUmlnYTEaMBgGA1UEChMRQ2l0YWRlbGUgQmFua2EgQVMxCzAJ\r\nBgNVBAsTAklUMRIwEAYDVQQDEwlBTUFJLXRlc3QwHhcNMTQwMTIwMTI0MTM1WhcNMTkwMTE5MTI0\r\nMTM1WjBrMQswCQYDVQQGEwJMVjEQMA4GA1UECBMHVW5rbm93bjENMAsGA1UEBxMEUmlnYTEaMBgG\r\nA1UEChMRQ2l0YWRlbGUgQmFua2EgQVMxCzAJBgNVBAsTAklUMRIwEAYDVQQDEwlBTUFJLXRlc3Qw\r\nggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCMw/Yj5Wv2PZo5kUQSGj8382mxZCCPefM0\r\noUW69PwNiJSAfLRIOMgNLFeqiYm94yD4IRe2LToYMhEHaxu+Hnf1Jqcn8M2TKq7MROcrclHMuvsE\r\nvgxSFwsTwM/tsunXD0XAeW4PQdIHv2ripklGJQWjTbNXnPMdUhIvqmX8VHSbPbS867Fv6oXRpcaZ\r\nO/qGPh3ezh4cGYU3uPw50lZynIA+Ch4cnia5iZcWg7W8chiHaTWT1vXlivGW4yOE/iQBR1213hqS\r\n37Bi9HGNVM9snKy9GgDPou7ZLZk9z22tghDWnT26Xa/TEW7m1XWl8Km5+eQCRaTMCSEDxKCX+Dfk\r\ntyaSW5csJewcWCW1ZruI/Qz+EmgzbEcYLkfoftXO9Cq428oUbYNysmLQXXoGJHzQ3Tec6eU3LPPB\r\n3KXhpudnTG8BBXyR3X9ka2OhNXLRj/OR+6OVlH9pQzQYcs6a7I5L4CRVnyqjLOxa2Oi0r6uc3Stz\r\nNrc1B7XWeRay6vxl02IPIjolVWxt0UkiN1duvnCe3msYFvN3nj/6B3EV+1sVWDUakus0qm8wb/oL\r\nXsN2qVHOKl+UOa9dAWxyyxXQ2OVrdGaPRbC3CM1JsZg4p6jVrxJ/Cc72tHFoRmzzrm25goh3ViRm\r\nGTOy6GmEymAPlM1W9fqg28ccCpLCShUNBAvQzEqVJQIDAQABoyEwHzAdBgNVHQ4EFgQUnSru52aI\r\ndffbxBlh3Y8rAjkyLKUwDQYJKoZIhvcNAQELBQADggIBAEcGvf6i3D1YuijArS4EbCTcMzpqLjBc\r\n52ER8qMqYQXDzDyk/U4U/NtD6Qlkl8h0LtR6q5yi1xtA5s1XJzEWUw5O2eqC09z2vKsYekECsZy2\r\n92xIEfnxkzimsA79G3VLhPScMpnt4L3Lii8uTV/BA85AR7GWtj9bw7t7bSGPpuyTizvJk+gsB2yb\r\nfkDm33lU6zfTJ4BhgPuYRD8NeOVMt/ObJ7xcjcqAs2rYgH5eHlshr+nDfhyJL0GROOLTM46bJakq\r\n2F5B4VAd5hhH2nXlDTeUDSSQ+ljX8gnSIcMb+Bdh78wmqOlVEL2eSpTERzmKATiA4n9Opuixw/1I\r\nAxp0ThkKg+SX2z5UpBXUnLJBd/8vaKjmEfaMM3XjZHTmGPgS2IXA6G99Zapv1zNYIDb1uFA1eBaJ\r\nYz3JVQo53wA4sUF3c4ZRXQWoe3mLenxvmInpwhT1jOYFetmkscJPLjHgIotMZrvpds53mQuV8eJG\r\nNDtoiykdFT8QK0HeVqg+wJTniiamidiSpndLJ9BEc49N68Vd8zUfv4Tv2VfZiaXuavnRM5DKavlz\r\nJ7OH0q4gcKAPgaIkL89o6vrvG8YDdubn13u6ilhOE5lBhtcfoRMCdw7QWgwCth9TK3vWGIdz6DDa\r\n7C5BJEt8IvZ574JX0YYuhFrVsu9E40prLfsGEiWPB0Gv</X509Certificate></X509Data></KeyInfo></Signature></SignatureData></Amai></Extension></Header></FIDAVISTA>
          EOF

        end

      end
    end
  end
end
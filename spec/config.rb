SacPS::Auth::Swedbank.identifier = 'ACC1'
SacPS::Auth::Swedbank.service_url = 'https://ib.swedbank.lv'
SacPS::Auth::Swedbank.return_url = 'http://www.myplace.com'

SacPS::Auth::Seb.identifier = 'ACC1'
SacPS::Auth::Seb.service_url = 'https://ibanka.seb.lv/ipc/epakindex.jsp'
#NO RETURN URL

SacPS::Auth::Citadele.identifier = ENV["CITADELE_IDENTIFIER"]
SacPS::Auth::Citadele.service_url = "https://astra.parex.lv/amai/start.htm"
SacPS::Auth::Citadele.return_url = 'http://lvh.me:3000/auth/citadele'

SacPS::Auth::Dnb.identifier = 'ACC1'
SacPS::Auth::Dnb.service_url = 'https://ib.dnb.lv/login/index.php'
SacPS::Auth::Dnb.return_url = 'http://www.myplace.com'

SacPS::Auth::Nordea.identifier = '87441733816'
SacPS::Auth::Nordea.service_url = 'https://ib.dnb.lv/login/index.php'
SacPS::Auth::Nordea.return_url = 'http://www.myplace.com'
SacPS::Auth::Nordea.cancel_url = 'http://www.myplace.com'
SacPS::Auth::Nordea.fail_url = 'http://www.myplace.com'
SacPS::Auth::Nordea.mac = 'ttetpptr0xyie3n20cd1gr725n7gp8ox'

SacPS::Auth::Swedbank.private_key = ENV["SWED_PRIVKEY"]
SacPS::Auth::Swedbank.public_key = <<-EOF
-----BEGIN CERTIFICATE-----
MIIDRTCCAq6gAwIBAgIBADANBgkqhkiG9w0BAQQFADB7MQswCQYDVQQGEwJFRTEO
MAwGA1UECBMFSGFyanUxEDAOBgNVBAcTB1RhbGxpbm4xDDAKBgNVBAoTA0VZUDEL
MAkGA1UECxMCSVQxDDAKBgNVBAMTA2EuYTEhMB8GCSqGSIb3DQEJARYSYWxsYXIu
YWxsYXNAZXlwLmVlMB4XDTk5MTExNTA4MTAzM1oXDTk5MTIxNTA4MTAzM1owezEL
MAkGA1UEBhMCRUUxDjAMBgNVBAgTBUhhcmp1MRAwDgYDVQQHEwdUYWxsaW5uMQww
CgYDVQQKEwNFWVAxCzAJBgNVBAsTAklUMQwwCgYDVQQDEwNhLmExITAfBgkqhkiG
9w0BCQEWEmFsbGFyLmFsbGFzQGV5cC5lZTCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAvgETpV4kb4tU+0PXwIdC8O97MwJ9upqnyg6negXaZat7/oFVgt79Pm4L
XzWpERP1FWDsRANM9L4qkaSsz7jcvDrLUzHvHxSrNfTVvJQWIpOjcyeAZPgelZqL
zptJyS0CcrVyoicrhz/Q6jzlZj/Evms81+1Ks6L9Z8aPX7x+8tkCAwEAAaOB2DCB
1TAdBgNVHQ4EFgQUFivCzZNmegEoOxYtg20YMMRB98gwgaUGA1UdIwSBnTCBmoAU
FivCzZNmegEoOxYtg20YMMRB98ihf6R9MHsxCzAJBgNVBAYTAkVFMQ4wDAYDVQQI
EwVIYXJqdTEQMA4GA1UEBxMHVGFsbGlubjEMMAoGA1UEChMDRVlQMQswCQYDVQQL
EwJJVDEMMAoGA1UEAxMDYS5hMSEwHwYJKoZIhvcNAQkBFhJhbGxhci5hbGxhc0Bl
eXAuZWWCAQAwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQQFAAOBgQBfkayuot+e
fwW8QmPwpWF5AY3oMT/fTncjCljDBOg39IQv4PjnpTdDfwwl3lUIZHHTLM2i0L/c
eD4D1UFM1qdp2VZzhBd1eeMjxYjCP8qL2v2MfLkCYcP30Sl6ISSkFjFc5qbGXZOc
C82uR/wUZJDw9kj+R1O46/byG8yA+S9FVw==
-----END CERTIFICATE-----
EOF

SacPS::Auth::Citadele.private_key = ENV["CITADELE_PRIVKEY"]
SacPS::Auth::Citadele.private_cert = ENV["CITADELE_PRIVATE_CERT"]
SacPS::Auth::Citadele.public_key = <<-EOF
-----BEGIN CERTIFICATE-----
MIIFdTCCA12gAwIBAgIEWjSIGzANBgkqhkiG9w0BAQsFADBrMQswCQYDVQQGEwJM
VjEQMA4GA1UECBMHVW5rbm93bjENMAsGA1UEBxMEUmlnYTEaMBgGA1UEChMRQ2l0
YWRlbGUgQmFua2EgQVMxCzAJBgNVBAsTAklUMRIwEAYDVQQDEwlBTUFJLXRlc3Qw
HhcNMTQwMTIwMTI0MTM1WhcNMTkwMTE5MTI0MTM1WjBrMQswCQYDVQQGEwJMVjEQ
MA4GA1UECBMHVW5rbm93bjENMAsGA1UEBxMEUmlnYTEaMBgGA1UEChMRQ2l0YWRl
bGUgQmFua2EgQVMxCzAJBgNVBAsTAklUMRIwEAYDVQQDEwlBTUFJLXRlc3QwggIi
MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCMw/Yj5Wv2PZo5kUQSGj8382mx
ZCCPefM0oUW69PwNiJSAfLRIOMgNLFeqiYm94yD4IRe2LToYMhEHaxu+Hnf1Jqcn
8M2TKq7MROcrclHMuvsEvgxSFwsTwM/tsunXD0XAeW4PQdIHv2ripklGJQWjTbNX
nPMdUhIvqmX8VHSbPbS867Fv6oXRpcaZO/qGPh3ezh4cGYU3uPw50lZynIA+Ch4c
nia5iZcWg7W8chiHaTWT1vXlivGW4yOE/iQBR1213hqS37Bi9HGNVM9snKy9GgDP
ou7ZLZk9z22tghDWnT26Xa/TEW7m1XWl8Km5+eQCRaTMCSEDxKCX+DfktyaSW5cs
JewcWCW1ZruI/Qz+EmgzbEcYLkfoftXO9Cq428oUbYNysmLQXXoGJHzQ3Tec6eU3
LPPB3KXhpudnTG8BBXyR3X9ka2OhNXLRj/OR+6OVlH9pQzQYcs6a7I5L4CRVnyqj
LOxa2Oi0r6uc3StzNrc1B7XWeRay6vxl02IPIjolVWxt0UkiN1duvnCe3msYFvN3
nj/6B3EV+1sVWDUakus0qm8wb/oLXsN2qVHOKl+UOa9dAWxyyxXQ2OVrdGaPRbC3
CM1JsZg4p6jVrxJ/Cc72tHFoRmzzrm25goh3ViRmGTOy6GmEymAPlM1W9fqg28cc
CpLCShUNBAvQzEqVJQIDAQABoyEwHzAdBgNVHQ4EFgQUnSru52aIdffbxBlh3Y8r
AjkyLKUwDQYJKoZIhvcNAQELBQADggIBAEcGvf6i3D1YuijArS4EbCTcMzpqLjBc
52ER8qMqYQXDzDyk/U4U/NtD6Qlkl8h0LtR6q5yi1xtA5s1XJzEWUw5O2eqC09z2
vKsYekECsZy292xIEfnxkzimsA79G3VLhPScMpnt4L3Lii8uTV/BA85AR7GWtj9b
w7t7bSGPpuyTizvJk+gsB2ybfkDm33lU6zfTJ4BhgPuYRD8NeOVMt/ObJ7xcjcqA
s2rYgH5eHlshr+nDfhyJL0GROOLTM46bJakq2F5B4VAd5hhH2nXlDTeUDSSQ+ljX
8gnSIcMb+Bdh78wmqOlVEL2eSpTERzmKATiA4n9Opuixw/1IAxp0ThkKg+SX2z5U
pBXUnLJBd/8vaKjmEfaMM3XjZHTmGPgS2IXA6G99Zapv1zNYIDb1uFA1eBaJYz3J
VQo53wA4sUF3c4ZRXQWoe3mLenxvmInpwhT1jOYFetmkscJPLjHgIotMZrvpds53
mQuV8eJGNDtoiykdFT8QK0HeVqg+wJTniiamidiSpndLJ9BEc49N68Vd8zUfv4Tv
2VfZiaXuavnRM5DKavlzJ7OH0q4gcKAPgaIkL89o6vrvG8YDdubn13u6ilhOE5lB
htcfoRMCdw7QWgwCth9TK3vWGIdz6DDa7C5BJEt8IvZ574JX0YYuhFrVsu9E40pr
LfsGEiWPB0Gv
-----END CERTIFICATE-----
EOF

SacPS::Auth::Dnb.private_key = ENV["DNB_PRIVKEY"]
SacPS::Auth::Dnb.public_key = <<-EOF
-----BEGIN CERTIFICATE-----
MIICsDCCAZgCAidPMA0GCSqGSIb3DQEBBQUAMBUxEzARBgNVBAMTCmlOT1JEIExpbmswHhcNMTIw
ODA5MTAyODE2WhcNMTUwODA5MTAyODE2WjAmMSQwIgYDVQQDExtpTk9SRCBMaW5rIGZvciBNYW5h
QmFsc3MubHYwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDA0o3nIumfRztAWiu95im+
Hu5NSUnv4vgok13a2DrudI50ik0cUR6p5hkFAc6ivcHfUifAWmyhA1PTgcpkyzEzcMRAHdxm32BG
0q5T1/pZqOyQ5e2dlit/ht0/E43kEitLK3qF2F1cHf7aMifGFO+fn5T2q2v1CT6h0klYZIQ6v8jW
SNcYQVwtfetQlVqSVJMEmimBielEmbZG+RzMspTUF8//tXlHwQH116BV+zolZFxOi3jl6djzDxOr
0KqVHH5EmIYRYhOJXzCnknmuAUgvUXVOMbQklMXRJO0PuKfCVPHADif4cuomDKdaUjB+1ohemjAZ
Y5QmxPinGuF136+ZAgMBAAEwDQYJKoZIhvcNAQEFBQADggEBAJnjlJ6v6VIZjUfL9RsexCZUvSmf
xNBo2KTNnsNqMwZNW/lOrrWNMnUPDmDPZAUK4X121CEGCu8F8cHpjbHlN/VDNY4aOicJAHDxIhVg
5gXZ0ArO2UAho0C3Jn3gmE4tl60AsALtUoW37Afv6DlUYXbwL2rH3o4wdV5qrtibyOl56sZa8ySs
ZIwxElbF0+5qQ9ZxZV8TgeeyaDHqdIAePKhl8DJdfxloPIizaCL6zckrteIINCfhvleKxpSMumbE
2cueKjDAVdR85/m/xeLeUtiYcZKj890cqCH95ymDP8jPe9l/K0wmsEu4V7XLMvBkv6w+CpHx5AJL
A1Nl8iRhloI=
-----END CERTIFICATE-----
EOF

TEST_CITADELE_RESPONSE = <<-EOF
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
                <DigestValue>4GRtwEyjYigO+u43v68RU86rkLA=</DigestValue>
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
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
SacPS::Auth::Citadele.public_key = <<-EOF
-----BEGIN CERTIFICATE-----
MIIFazCCA1OgAwIBAgIENlLsbjANBgkqhkiG9w0BAQsFADBmMQswCQYDVQQGEwJM
VjEQMA4GA1UECBMHVW5rbm93bjENMAsGA1UEBxMEUmlnYTEaMBgGA1UEChMRQ2l0
YWRlbGUgQmFua2EgQVMxCzAJBgNVBAsTAklUMQ0wCwYDVQQDEwRBTUFJMB4XDTE0
MDExNzE0NTg0NloXDTE5MDExNjE0NTg0NlowZjELMAkGA1UEBhMCTFYxEDAOBgNV
BAgTB1Vua25vd24xDTALBgNVBAcTBFJpZ2ExGjAYBgNVBAoTEUNpdGFkZWxlIEJh
bmthIEFTMQswCQYDVQQLEwJJVDENMAsGA1UEAxMEQU1BSTCCAiIwDQYJKoZIhvcN
AQEBBQADggIPADCCAgoCggIBAMkERaCZKMHu3hMUHbJmXYZnuKIIk9GhNzW4mkSm
qcHaD845wEFCXgN/PEV+4W/8XkHRd6jDeiEhDzIPts9kUsrWZGJ7yFw5vF/WGKlM
6IYHF6immkCs3EibDvAurLwCpNhQcAXsf06visVFj3Sz4cbinqQfkZhPvYcaDR3K
BwxBASFC+4xOJFkXDq2B2etZ6fkvmVGTv5ONZ1Hli8EurU6gAaHD1uT4LCsKzyjy
QCmzUfhjSz/qrt0Lqup445T3Jwp6Nswo2qKCf2McH7o5Y58ZhyKBbpat4kmLDClF
F8+DZOPN/YFLfRxXvy3gdYVZrWJ18kLTgPdynroCXrFRCYhRxNV8M13Iv9C6lFEA
nTxqOvJG2SZHcmHI3sUIneqDqTBGNJhy0sxBmIZE9sxyd0q+YaJO1wZspc/8BBxu
Qg5X5iXLt8mE21xczr3XtbWmj9wbWaLGZGRuR9mUWlszlGJm/ejaPN+ocTOo6D1k
VUKoxHYy/J2uwC6PMUgEW4tEZAEcJ6CZrm2FfqAiDWuk8/EHSpAX3rfTVJ27zF4Z
tm0x/LbDMD0HvBklgQ+4fv+pDvzzDGxdYDZAzEHuxoMKvQhzsO/ArrCN6HgU5+BY
N/CHL3PMQ8+SAL9swOrv8rM6u7KGNIX8JAdaxTUaMBxeDMnYnt/mXwCeXhVlcKkw
FhD5AgMBAAGjITAfMB0GA1UdDgQWBBSDV1HGPdL5jDVKo84lY0Aiv5MIXDANBgkq
hkiG9w0BAQsFAAOCAgEABAD9oFeOC5zBGMVeSNNdLON0PPEAjVGs8dN5LHkYTPwL
/nNpcS89f58pHhbvuxoAZ1V8oPi60nTiun7xyeQPX6xUHFbBBvU9XEEMpdb5/fti
Uia/g7kO/XbzH32QPYzIg+A2XE6Zt2EKi0S+TLotrV0Dw9cp5kEBzraZLUPuY1nb
dcS1BgO80TeVoxzK5qnXTknDKyW6E/kPcC9BJScZ/+JsMRF9a8moLQRgWVM3ZzVQ
xNEhCUfPma7csuSU2xqHkqWAcuZlaPTk12hhBKcTj3TO/M+U5hvC87OHU9FmHkc5
8gfbCuXbsaqTv0egZDtdiSB+AxP5bAcZsSLLPkD1hlffbYMJ01xa+k8dSWb/GVqJ
MHIrn7j7UnxsiYXBuEsl8ZOR/tZshgmf9TJVIQ5iswiHPmBB9rvcqFWE5OVgEVBh
vJjQBoxXdFWM9ZREdb6R91WX4eXl5ZjPxF8VfvF5jEQFtGLRsQNZx6XiSZKVhrrw
EEHlVMbuFwdLQghXKCNTXlmXjKAU2DK5ft2PcB5lHOWvEF3xQrINnghhCl9m7pz5
9pc8N1xDO2rtO1sb8j2JweTfiQqwlKSf7HvEcd9SeJyCwu7BVHUUKabfUzDGxCSH
ImUgh1Ek3tG+lC/6HKlXaLflBkxu6J6E2mDZKJl/gML22KQ59FtuhIOCJTs9OlU=
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
                <DigestValue>PV1yPEmQ...</DigestValue>
              </Reference>
            </SignedInfo>
            <SignatureValue>GFzAo2U5fY...</SignatureValue>
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
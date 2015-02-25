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
MIIFhDCCA2wCCQCegSod3y7vmjANBgkqhkiG9w0BAQUFADCBgzELMAkGA1UEBhMC
TFYxDDAKBgNVBAgMA1VTQTENMAsGA1UEBwwEUmlnYTEYMBYGA1UECgwPQ3JlYXRp
dmUgTW9iaWxlMQswCQYDVQQLDAJJVDEPMA0GA1UEAwwGQXJ0dXJzMR8wHQYJKoZI
hvcNAQkBFhBhcnR1cnNAY3Jlby5tb2JpMB4XDTExMTEyMjE2MjIxMFoXDTE1MTEy
MTE2MjIxMFowgYMxCzAJBgNVBAYTAkxWMQwwCgYDVQQIDANVU0ExDTALBgNVBAcM
BFJpZ2ExGDAWBgNVBAoMD0NyZWF0aXZlIE1vYmlsZTELMAkGA1UECwwCSVQxDzAN
BgNVBAMMBkFydHVyczEfMB0GCSqGSIb3DQEJARYQYXJ0dXJzQGNyZW8ubW9iaTCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALykOU4K/D4IoKhnYUMfHrZM
syUo3NQyNJ4UWLMc89DPtRNu1hUyPtXme/zoNeElL5cTT2ltmdD6c/wrKp0JOJX0
4wrkUVAiyTMTORjC/zAmhpKezyHuirnNV4E7t0A8DBKdux4jeU2cECghVz21VxV7
el9SY7So9qpzrRztsLw+11D0Zun6kW3SLmfPnQs2k6BLgO2D6FFJbW3nXKqaGH6e
hY8EnQL2Pf5fRpQY2jx01i2+6oumRQqbDVphN7AqtgZlPhks+VnNR1PE8EGsRcdU
PgH/ZmBzdRGRe1bonngEclkpQUd6poa90xXQ4BtCXURhAYNUF6x5n8MSm6rKi/1e
T2SORfoV1nTeQZLfVHYPvjIi8KL0KzDsJn6gaP3ApZiF+BKwZZmO/8X8ICPJKdwS
afbRziyunZjLvj69IFibN3twib51OYmbdr1yo7qilTRsX7fi0kIaFB8i6VHhJVyu
6RUGYVvsCxSwMwrk0klSFD7S3afyC3KpsBykAFPwgeFXlJO+2ubF0CwL1kpG2OtY
cHq7EvNqeJy3SHJwzjktd5z+pPpgVkvn4sxmNqtadbU+lKDa7tF5yLsQXzoRZtCb
Y/m+cYUGTmNftcuoadj2e8BWHj1FEy1t8CQuM5shWfKKhhhCeqyuTuOxCvS08fdF
hOqcM621BddpFjXzczUpAgMBAAEwDQYJKoZIhvcNAQEFBQADggIBAFczQspZRvxP
mKmMEMSqjJy2HfhkeU6eAbJYIXQX19mveIscUzG/pWxOS5j6F9B1wS8EmIRgz5EW
KN0LdPXpfvy1R9yMGgiZW4JyyfTWgTNOQcVuN8QPltkMzEAqDnOd4gkF41N9qf42
/5wSzcU+rCF89UpdIig7KRopgyCcThRgBJ0UgqaSTm1qL+/+AZxzGjbPr4a+U2/A
xWzsoDA61zo/v6nQ3ZPCWiGoKsA1eO8Vh1YihTPo2HyrMgtXyWvG3p9DiNvyh6xP
vIGu5yJfxfa20X/xuHWB1xuyEF0NHq0Bb+7esvkZiNSALUlQSiUwdlN1cRv5UCtu
WeR1/4nboKV97euM1kP+f30Vrqs1RUlonDwiDlgBbUCFlU3OUomW4D9Lxhsi3Gab
pMI3HpjZ+8mazDdRxtD2TCmzGo+YjOwLUrXlVP0AHXAOaSWfQacleCAVyyH0ffE5
dByjB9tSIcxDijIkw1PHGazDnHKqOmG3VIVCQHS30xA+gjFrn1791grNQOI3pM/6
Gbhw8XRx6vks2T6yhAHDaCK+jOwLakW9pmheVG4DFxqSKXaLRQm+KOGQMhBzNKFO
mkqsF3eDhhx538HVDzbiqye7R21GhnCCZoEiPC0UcHDOKm3Yow3yQ64NON74lQCM
i02yWxFjh9NodTVRcdb4WBmSXprepw3G
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
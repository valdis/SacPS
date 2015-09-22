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
SacPS::Auth::Citadele.public_key = ENV["CITADELE_PUBLIC_KEY"]

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

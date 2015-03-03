# rspec spec/auth/helpers/sacps_auth_citadele_helper_spec.rb

require 'spec_helper'

describe SacPS::Auth::Citadele::Helper do

  let(:helper) { SacPS::Auth::Citadele.helper }

  it "should initialize helper with no arguments" do
    SacPS::Auth::Citadele.validate_config!
    puts helper.xml
    expect(helper.present?).to eq true
  end

  it "should return correct identifier" do
    expect(helper.identifier).to eq ENV["CITADELE_IDENTIFIER"]
  end

  it "should return correct private cert" do
    expect(SacPS::Auth::Citadele.get_private_cert).to eq "MIIFhDCCA2wCCQCegSod3y7vmjANBgkqhkiG9w0BAQUFADCBgzELMAkGA1UEBhMCTFYxDDAKBgNVBAgMA1VTQTENMAsGA1UEBwwEUmlnYTEYMBYGA1UECgwPQ3JlYXRpdmUgTW9iaWxlMQswCQYDVQQLDAJJVDEPMA0GA1UEAwwGQXJ0dXJzMR8wHQYJKoZIhvcNAQkBFhBhcnR1cnNAY3Jlby5tb2JpMB4XDTExMTEyMjE2MjIxMFoXDTE1MTEyMTE2MjIxMFowgYMxCzAJBgNVBAYTAkxWMQwwCgYDVQQIDANVU0ExDTALBgNVBAcMBFJpZ2ExGDAWBgNVBAoMD0NyZWF0aXZlIE1vYmlsZTELMAkGA1UECwwCSVQxDzANBgNVBAMMBkFydHVyczEfMB0GCSqGSIb3DQEJARYQYXJ0dXJzQGNyZW8ubW9iaTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALykOU4K/D4IoKhnYUMfHrZMsyUo3NQyNJ4UWLMc89DPtRNu1hUyPtXme/zoNeElL5cTT2ltmdD6c/wrKp0JOJX04wrkUVAiyTMTORjC/zAmhpKezyHuirnNV4E7t0A8DBKdux4jeU2cECghVz21VxV7el9SY7So9qpzrRztsLw+11D0Zun6kW3SLmfPnQs2k6BLgO2D6FFJbW3nXKqaGH6ehY8EnQL2Pf5fRpQY2jx01i2+6oumRQqbDVphN7AqtgZlPhks+VnNR1PE8EGsRcdUPgH/ZmBzdRGRe1bonngEclkpQUd6poa90xXQ4BtCXURhAYNUF6x5n8MSm6rKi/1eT2SORfoV1nTeQZLfVHYPvjIi8KL0KzDsJn6gaP3ApZiF+BKwZZmO/8X8ICPJKdwSafbRziyunZjLvj69IFibN3twib51OYmbdr1yo7qilTRsX7fi0kIaFB8i6VHhJVyu6RUGYVvsCxSwMwrk0klSFD7S3afyC3KpsBykAFPwgeFXlJO+2ubF0CwL1kpG2OtYcHq7EvNqeJy3SHJwzjktd5z+pPpgVkvn4sxmNqtadbU+lKDa7tF5yLsQXzoRZtCbY/m+cYUGTmNftcuoadj2e8BWHj1FEy1t8CQuM5shWfKKhhhCeqyuTuOxCvS08fdFhOqcM621BddpFjXzczUpAgMBAAEwDQYJKoZIhvcNAQEFBQADggIBAFczQspZRvxPmKmMEMSqjJy2HfhkeU6eAbJYIXQX19mveIscUzG/pWxOS5j6F9B1wS8EmIRgz5EWKN0LdPXpfvy1R9yMGgiZW4JyyfTWgTNOQcVuN8QPltkMzEAqDnOd4gkF41N9qf42/5wSzcU+rCF89UpdIig7KRopgyCcThRgBJ0UgqaSTm1qL+/+AZxzGjbPr4a+U2/AxWzsoDA61zo/v6nQ3ZPCWiGoKsA1eO8Vh1YihTPo2HyrMgtXyWvG3p9DiNvyh6xPvIGu5yJfxfa20X/xuHWB1xuyEF0NHq0Bb+7esvkZiNSALUlQSiUwdlN1cRv5UCtuWeR1/4nboKV97euM1kP+f30Vrqs1RUlonDwiDlgBbUCFlU3OUomW4D9Lxhsi3GabpMI3HpjZ+8mazDdRxtD2TCmzGo+YjOwLUrXlVP0AHXAOaSWfQacleCAVyyH0ffE5dByjB9tSIcxDijIkw1PHGazDnHKqOmG3VIVCQHS30xA+gjFrn1791grNQOI3pM/6Gbhw8XRx6vks2T6yhAHDaCK+jOwLakW9pmheVG4DFxqSKXaLRQm+KOGQMhBzNKFOmkqsF3eDhhx538HVDzbiqye7R21GhnCCZoEiPC0UcHDOKm3Yow3yQ64NON74lQCMi02yWxFjh9NodTVRcdb4WBmSXprepw3G"
  end

  it "should initialize with an unique_identifier" do
    expect(helper.uuid.present?).to eq true
    expect(helper.uuid.size).to eq 36
  end

  it "should return correct return_url" do
    expect(helper.return_url).to eq 'http://lvh.me:3000/auth/citadele'
  end

  it "should create correct amount of fields" do
    expect(helper.form_fields.size).to eq 1
  end

  it "should create correct digest" do
    digest = helper.xml.match(/(?<=<DigestValue>).*?(?=<\/DigestValue>)/).to_s
    expect(digest.size).to be > 20
    expect(digest.last).to eq "="
  end

  it "should create correct signed_info xml element block" do
    signature = helper.xml.match(/(?<=<SignatureValue>)(\n|.)*?(?=<\/SignatureValue>)/).to_s
    expect(signature.size).to be > 650
    expect(signature.last).to eq "="
  end

end
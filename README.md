# Payment and Auth system gem

## Development setup
This project uses rspec and dotenv.  
See .env_example for how to set up easy citadele certs.

Start by creating .env file in root and defining some environmental variables.

When ready, do `rspec` to run the test suite.

## Standarts
Authentification system functionalities are packed in two namespaces - `helper` and `notification`

#### Helper
Does everything leading up to sending the request to remote service.  
Usually this means request url and data setup

#### Notification
Does everything after receiving response from remote service.  
Usually there is a create controller action where notification object is instatiated:

```ruby
notification = SacPS::Auth::<AuthSystem>.notification(params[:some_param])
create_and_or_login_user notification
```

Notification object _must_ define `user_identifier` and `user_name` as a minimum.  

```ruby
notification.user_identifier #=> "311299-11111"
notification.user_name       #=> "Askolds Buksis"
```

### Swedbank usage

1. Configure defaults
2. Initialize the helper
3. Expect a response at the return_url you specified
4. Instantiate a notification object

```ruby
# GET version
received_params = request.url.split("?").last
@response = Banklink::Swedbank.notification received_params
# POST version
received_params = request.raw_post
@response = Banklink::Swedbank.notification received_params

@response.inspect #=>
"#<Banklink::Swedbank::Notification:0x007fafb6ad9e28
@options={},
@params={
  "VK_SERVICE"=>"1101"
  "VK_VERSION"=>"008"
  "VK_SND_ID"=>"HP"
  "VK_REC_ID"=>"REFEREND"
  "VK_STAMP"=>"1"
  "VK_T_NO"=>"169"
  "VK_AMOUNT"=>"0.01"
  "VK_CURR"=>"EUR"
  "VK_REC_ACC"=>"XXXXXXXXXX"
  "VK_REC_NAME"=>"FONDS"
  "VK_SND_ACC"=>"XXXXXXXXXXXX"
  "VK_SND_NAME"=>"JOHNNY BRAVO"
  "VK_REF"=>""
  "VK_MSG"=>"Manabalss ziedojums par €0.01 | UniqID: 455"
  "VK_T_DATE"=>"10.03.2015"
  "VK_LANG"=>"LAT"
  "VK_AUTO"=>"N"
  "VK_ENCODING"=>"UTF-8"
  "VK_MAC"=>"ObqLDaCTNOdFueilODycvjz3e1oExPaj8XMzYf1pc0FrYoCvxoqSNy4d/9aCLdbMYL2hecdLxY/T+cTCNty3LBbcjxQPyJeo7bhQ0MKaNEL38PvZKnVc0GCK1kSeXSenJVCgTKh//YfnuDcziwyR1t5PnwLvQP6Qlx7AbGPOe6A="},
@raw="VK_SERVICE=1101&VK_VERSION=008&VK_SND_ID=HP&VK_REC_ID=REFEREND&VK_STAMP=1....QP6Qlx7AbGPOe6A%3D">"
```

### Citadele usage

1. Add secret environmental variables (nano /etc/environment)

```
CITADELE_IDENTIFIER="10000" # Your identifier here
CITADELE_PRIVKEY="Fjiowe78hiIYA..." # Your private key here
CITADELE_PRIVATE_CERT="QqIIFhDCCA2wCCQCegSod3..." # Your certificate stripped of first and last line (the ----BEGIN CERTIFICATE stuff)
```

2. Configure defaults

```ruby
SacPS::Auth::Citadele.identifier   = ENV["CITADELE_IDENTIFIER"] # Your merchant number with Citadele
SacPS::Auth::Citadele.private_key  = ENV["CITADELE_PRIVKEY"]
SacPS::Auth::Citadele.private_cert = ENV["CITADELE_PRIVATE_CERT"]
SacPS::Auth::Citadele.public_key   = File.read("#{Rails.root}/certs/citadele.crt")
SacPS::Auth::Citadele.return_url   = "https://your-domain.com/auth/citadele"
SacPS::Auth::Citadele.service_url  = "https://online.citadele.lv/amai/start.htm" # Defined in defaults, can skip
SacPS::Auth::Citadele.validate_config! # This will raise an error if you missed something
```

3. Initialize the helper

```ruby
@request_helper = SacPS::Auth::Citadele.helper
```

4. Helper methods

```ruby
  @request_helper.identifier #=> "10000"
  @request_helper.return_url #=> "http://www.some-domain.com"
  @request_helper.uuid       #=> "7387bf5b-fa27-4fdd-add6-a6bfb2599f77"
  @request_helper.xml        #=>
# <?xml version="1.0"?>
# <FIDAVISTA xmlns="http..."
  @request_helper.form_fields #=> { "xmldata" => @request_helper.xml }
```

5. Build an automatic submit form  
Use SacPS::Auth::Citadele.service_url and @request_helper.xml

```html
# views/auth/citadele/new.html.erb
<html>
  <head>
  </head>
  <body onload="document.citadeleForm.submit();" style="display:none;">
  <form method="POST" name="citadeleForm" action="<%= SacPS::Auth::Citadele.service_url %>">
    <input type="hidden" id="xmldata" name="xmldata" value="<%= @request_helper.xml %>">
    <input type="submit" value="Send">
  </form>
  </body>
</html>
```

6. Expect a response at the return_url you specified
7. Instantiate a notification object

```ruby
@response = SacPS::Auth::Citadele.notification(params["xmldata"])
```

8. Check if response is valid and process

```ruby
if @response.valid?
  @response.user_identifier #=> "123456-12345"
  @response.user_name       #=> "BĒRZIŅŠ JĀNIS" (< Citadele default)
  @response.from            #=> "CITADELE"
  @response.xml             #=> XML content
  @response.response_hash   #=> Nokogiri extracted values of XML content
  @response.code            #=> "100", "200" or "300"
  @response.message         #=> Only present if code !"100"
  @response.uuid            #=> "7387bf5b-fa27-4fdd-add6-a6bfb2599f77" (the same you supplied)
```

### DraugiemID usage

Documentation is online at [Draugiem site](https://www.draugiem.lv/applications/dev/docs/draugiemid)

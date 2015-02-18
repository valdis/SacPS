module SacPS
  module Auth
    module Citadele
      class Notification
        require 'Nokogiri'

        attr_reader :xml, :response_hash, :code, :message,
          :user_identifier, :user_name, :from, :ok

        def initialize(xml)
          begin
            @xml = xml
            @response_hash = parse_response(@xml)
            @code = @response_hash["Code"]
            @message = @response_hash["Message"]

            @user_identifier = @response_hash["PersonCode"].split("").insert(6,"-").join #=> "123456-12345"
            @user_name       = @response_hash["Person"].split(" ").rotate.join(" ") #=> "BĒRZIŅŠ JĀNIS" (< Citadele default)
            @from            = "CITADELE"
            @ok = is_ok?
          rescue => e
            puts e.message
            @ok = false
          end
        end

        def is_ok?
          return signature_ok? # &&
        end

        def signature_ok?
          digi_signature = response_hash["digiSignature"]
          hash_string = build_hashable_string
          decoded_resp = Base64.decode64(digi_signature)
          public_key = OpenSSL::X509::Certificate.new( (File.read SacPS::Auth::Citadele.public_key).public_key )
          return public_key.verify(OpenSSL::Digest::SHA1.new, decoded_resp, hash_string)
        end

        def self.init_test_response
          self.new(File.read "#{SacPS.root}/example_rsp.xml")
        end

        private

          def parse_response xml
            @response = Nokogiri::XML(xml) do |config|
              config.strict.nonet
            end
            @response.remove_namespaces!

            return {
              "Timestamp" => @response.xpath("//Timestamp").text,
              "From" => @response.xpath("//From").text,
              "Request" => @response.xpath("//Request").text,
              "RequestUID" => @response.xpath("//RequestUID").text,
              "Version" => @response.xpath("//Version").text,
              "Language" => @response.xpath("//Language").text,
              "PersonCode" => @response.xpath("//PersonCode").text,
              "Person" => @response.xpath("//Person").text,
              "Code" => @response.xpath("//Code").text, # Important
              "Message" => @response.xpath("//Message").text,
              "SignatureData" => @response.xpath("//SignatureData").text.strip
            }
          end

          def build_hashable_string
            rh = @response_hash
            return "#{rh["Timestamp"]}#{rh["From"]}#{rh["Request"]}#{rh["RequestUID"]}#{rh["Version"]}#{rh["Language"]}#{rh["PersonCode"]}#{rh["Person"]}#{rh["Code"]}#{rh["Message"]}"
          end

      end
    end
  end
end
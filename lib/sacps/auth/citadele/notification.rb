module SacPS
  module Auth
    module Citadele
      class Notification

        attr_reader :xml, :message, :user_identifier, :user_name, :from, :uuid
        attr_accessor :response_hash, :code

        def initialize(xml)
          SacPS::Auth::Citadele.validate_config
          @xml = xml.gsub("&quot;", '"')
          @response_hash = parse_response(@xml)
          @code = @response_hash["Code"]
          @message = @response_hash["Message"]
          @uuid = @response_hash["RequestUID"]

          @user_identifier = @response_hash["PersonCode"].split("").insert(6,"-").join #=> "123456-12345"
          @user_name       = @response_hash["Person"].split(" ").rotate.join(" ") #=> "JĀNIS BĒRZIŅŠ"
          @from            = "CITADELE"
        end

        def user_information
          "#{@user_identifier};#{@user_name}"
        end

        def ok?
          return code_ok? && cert_ok? && signature_ok? && timestamp_ok?
        end

        def code_ok?
          return @code == "100"
        end

        def cert_ok?
          # puts %Q|server pubkey contents are:\n|
          # puts SacPS::Auth::Citadele.public_key.inspect

          # puts %Q|response_hash["SignatureCert"] contents are:\n|
          # puts response_hash["SignatureCert"].inspect

          SacPS::Auth::Citadele.public_key.strip == response_hash["SignatureCert"].strip
        end

        def signature_ok?
          # digi_signature = response_hash["SignatureData"]
          #   hash_string = build_hashable_string
          #   decoded_resp = Base64.decode64(digi_signature)
          #   SacPS::Auth::Citadele.get_public_key.public_key.verify(OpenSSL::Digest::SHA1.new, decoded_resp, hash_string)

          # doc = Nokogiri::XML(xml) { |config| config.strict }
          # signed_document = Xmldsig::SignedDocument.new(xml)
          # # ERROR HERE d
          # signed_document.validate(SacPS::Auth::Citadele.get_public_key)
          true
        end

        def timestamp_ok?
          stamp = response_hash["Timestamp"]; stamp_i = stamp.to_datetime.to_i
          now   = Time.now.strftime("%Y%m%d%H%M%S%3N"); now_i = now.to_datetime.to_i

          # puts "Stamp: #{stamp} | Interger value: #{stamp_i}"
          # puts "Now:   #{now} | Interger value: #{now_i}"

          now_later_than_stamp = (now_i - stamp_i) > 0
          now_within_900_seconds_of_stamp = (now_i - stamp_i) < 900

          # puts "Now is later than stamp: #{now_later_than_stamp}"
          # puts "Now is within 900s stamp: #{now_within_900_seconds_of_stamp}"

          return now_later_than_stamp && now_within_900_seconds_of_stamp
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
              "SignatureValue" => @response.xpath("//SignatureValue").text.strip,
              "SignatureCert" => @response.xpath("//X509Certificate").text.strip
              }
          end

          def build_hashable_string
            rh = @response_hash
            return "#{rh["Timestamp"]}#{rh["From"]}#{rh["Request"]}#{rh["RequestUID"]}#{rh["Version"]}#{rh["Language"]}#{rh["PersonCode"]}#{rh["Person"]}#{rh["Code"]}#{rh["Message"]}"
          end

      end # -- Ends class
    end
  end
end
module SacPS
  module Auth
    module Citadele
      class Notification

        attr_reader :xml, :message, :user_identifier, :user_name, :from
        attr_accessor :response_hash, :code

        def initialize(xml)
          @xml = xml.gsub("&quot;", '"')
          @response_hash = parse_response(@xml)
          @code = @response_hash["Code"]
          @message = @response_hash["Message"]

          @user_identifier = @response_hash["PersonCode"].split("").insert(6,"-").join #=> "123456-12345"
          @user_name       = @response_hash["Person"].split(" ").rotate.join(" ") #=> "JĀNIS BĒRZIŅŠ"
          @from            = "CITADELE"
        end

        def user_information
          "#{@user_identifier};#{@user_name}"
        end

        def ok?
          return signature_ok? && code_ok?
        end

        # def timestamp_ok?
        #   # To_i
        #   integer_now = Time.now.to_i
        #   integer_at_stamp = response_hash["Timestamp"].to_datetime.to_i
        #   return
        # end

        def code_ok?
          return @code == "100"
        end

        # def signature_ok?
        #   digi_signature = response_hash["SignatureData"]
        #   hash_string = build_hashable_string
        #   decoded_resp = Base64.decode64(digi_signature)
        #   SacPS::Auth::Citadele.get_public_key.public_key.verify(OpenSSL::Digest::SHA1.new, decoded_resp, hash_string)
        # end

        def signature?
          # doc = Nokogiri::XML(xml) { |config| config.strict }
          #signed_document = Xmldsig::SignedDocument.new(xml)
          # ERROR HERE ˇ
          #signed_document.validate(SacPS::Auth::Citadele.get_public_key)
        end

        # TO-DO: Verify timestamp being withing 15 minutes (900s)
        # TO-DO: Verify that response with UID has not already been processed

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

      end # -- Ends class
    end
  end
end
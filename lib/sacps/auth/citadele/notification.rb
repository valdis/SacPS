module SacPS
  module Auth
    module Citadele
      class Notification

        attr_reader :user_identifier, :user_name, :from, :uuid
        attr_accessor :response_hash, :code, :xml, :message

        IMPLEMENTED_RESPONSES = ['ESERVICEREQ', 'AUTHRESP']

        def initialize(xml)
          SacPS::Auth::Citadele.validate_config!
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

        def valid?
          return code_ok? && request_type_ok? && timestamp_ok? && signature_ok?
        end

        def code_ok?
          case @code
          when '100'
            return true
          when '200'
            raise "AuthenticationCancelledError"
          when '300'
            raise @message
          end
        end

        def signature_ok?
          xmldsig = Xmldsig::SignedDocument.new(@xml)
          xmldsig.validate(SacPS::Auth::Citadele.get_public_key) ? true : (raise "InvalidXMLSignatureError")
        end

        def timestamp_ok?
          stamp = response_hash["Timestamp"]; stamp_i = stamp.to_datetime.to_i
          now   = Time.now.strftime("%Y%m%d%H%M%S%3N"); now_i = now.to_datetime.to_i
          now_later_than_stamp = (now_i - stamp_i) > 0
          now_within_900_seconds_of_stamp = (now_i - stamp_i) < 900

          if now_later_than_stamp && now_within_900_seconds_of_stamp
            return true
          else
            raise "RequestExpiredError"
          end
        end

        def request_type_ok?
          raise "UnimplementedRequestError", "#{response[:request]} not implemented" unless IMPLEMENTED_RESPONSES.include? @response_hash["Request"]
          return true
        end

        private

          def parse_response xml
            doc = Nokogiri::XML(xml) do |config|
              config.strict.nonet
            end
            doc.remove_namespaces!

            return {
              "Timestamp" => doc.xpath("//Timestamp").text, # Verify
              "From" => doc.xpath("//From").text,
              "Request" => doc.xpath("//Request").text,
              "RequestUID" => doc.xpath("//RequestUID").text, # Verify
              "Version" => doc.xpath("//Version").text,
              "Language" => doc.xpath("//Language").text,
              "PersonCode" => doc.xpath("//PersonCode").text, # Use
              "Person" => doc.xpath("//Person").text, # Use
              "Code" => doc.xpath("//Code").text, # Verify
              "Message" => doc.xpath("//Message").text
              }
          end

      end # -- Ends class
    end
  end
end

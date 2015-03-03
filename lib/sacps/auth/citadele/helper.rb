module SacPS
  module Auth
    module Citadele
      class Helper

        include SacPS::Auth::Common
        include SacPS::Auth::Citadele

        attr_accessor :identifier, :return_url, :xml, :form_fields, :uuid, :unsigned_xml_part, :digest, :signed_info, :signature,
          :timestamp, :request, :version, :language

        def initialize
          SacPS::Auth::Citadele.validate_config!
          @identifier = SacPS::Auth::Citadele.identifier
          @return_url = SacPS::Auth::Citadele.return_url

          @timestamp = Time.now.strftime("%Y%m%d%H%M%S%3N") # "20030905175959000"
          @request = "AUTHREQ"
          @version = "3.0"
          @language = "LV"
          @uuid = SecureRandom.uuid # "7387bf5b-fa27-4fdd-add6-a6bfb2599f77"

          @xml = return_signed_request_xml
          @form_fields = { "xmldata" => @xml }
        end

      end # -- Class Helper ends
    end
  end
end
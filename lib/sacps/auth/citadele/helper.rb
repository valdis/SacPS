module SacPS
  module Auth
    module Citadele
      class Helper

        include SacPS::Auth::Common
        include SacPS::Auth::Citadele

        attr_accessor :identifier, :return_url, :xml, :form_fields, :uuid

        def initialize
          raise "Citadele cert init failed! See readme." if ENV["CITADELE_IDENTIFIER"].blank? || SacPS::Auth::Citadele.private_key.blank?
          @identifier = SacPS::Auth::Citadele.identifier
          @return_url = SacPS::Auth::Citadele.return_url
          @uuid = SecureRandom.uuid # "7387bf5b-fa27-4fdd-add6-a6bfb2599f77"

          @xml = return_signed_request_xml
          @form_fields = { "xmldata" => @xml }
        end

      end # -- Class Helper ends
    end
  end
end
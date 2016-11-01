module SacPS
  module Auth
    module Seb
      class Notification
        include SacPS::Auth::Common

        attr_accessor :params
        attr_accessor :raw

        def initialize(post, options = {})
          @options = options
          emptify!
          parse(post)
        end

        def user_information
          data = params['IB_USER_INFO'].split(";")
          identifier = data.first.split("=").last
          name = data.last.split("=").last
          return "#{identifier};#{name}"
        end

        def user_identifier
          user_information.split(";").first
        end

        def user_name
          user_information.split(";").last
        end

        def user_language
          case params['IB_LANG']
          when "LAT"
            return "lv"
          when "ENG"
            return "en"
          when "RUS"
            return "ru"
          else
            return "lv"
          end
        end

        def valid?
          bank_signature_valid?('0005', params)
        end

        private

        def emptify!
          @params  = Hash.new
          @raw     = ""
        end

        def signature
          Base64.decode64(params['IB_CRC'])
        end

        def bank_signature_valid? service_msg_number, sigparams
          digest = OpenSSL::Digest::SHA1.new
          data_string = generate_data_string(service_msg_number, sigparams, SacPS::Auth::Seb.required_service_params)
          SacPS::Auth::Seb.get_bank_public_key.verify digest, signature, data_string
        end

      end
    end
  end
end

module SacPS
  module Auth
    module Dnb
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
          "#{params['VK_PER_CODE']};#{params['VK_PER_FNAME']} #{params['VK_PER_LNAME']}"
        end

        def user_identifier
          user_information.split(";").first
        end

        def user_name
          user_information.split(";").last
        end

        def user_language
          case params['VK_LANG']
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
          bank_signature_valid?('2001', params)
        end

        private

        def emptify!
          @params  = Hash.new
          @raw     = ""
        end

        def signature
          Base64.decode64(params['VK_MAC'])
        end

        def bank_signature_valid? service_msg_number, sigparams
          digest = OpenSSL::Digest::SHA1.new
          data_string = generate_data_string(service_msg_number, sigparams, SacPS::Auth::Dnb.required_service_params)
          SacPS::Auth::Dnb.get_bank_public_key.verify digest, signature, data_string
        end
      end
    end
  end
end

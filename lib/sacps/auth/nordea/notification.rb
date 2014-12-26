module SacPS
  module Auth
    module Nordea
      class Notification
        include SacPS::Auth::Common 
        include SacPS::Auth::Nordea
        
        attr_accessor :params
        attr_accessor :raw

        def initialize(post, options = {})
          @options = options
          emptify!
          parse(post)
        end

        def user_information
          identifier = params['B02K_CUSTID']
          identifier = identifier.split(//).first(6).join+"-"+identifier.split(//).last(5).join

          full_name = params['B02K_CUSTNAME']
          full_name = full_name.split(" ").reverse.join(" ").upcase

          "#{identifier};#{full_name}"
        end

        def user_identifier
          user_information.split(";").first
        end

        def user_name
          user_information.split(";").last
        end

        def valid?
          bank_signature_valid?
        end

        private
          def generate_fields_for_calc
            str = ''
            required_params = self.required_response_params_for_mac_calc
            
            required_params.each do |param|
              val = CGI.escape(params[param].to_s)
              str << "#{val}&"
            end
            str << "#{SacPS::Auth::Nordea.mac.to_s}&"

            str
          end

          def mac
            params['B02K_MAC']
          end

          def emptify!
            @params  = Hash.new
            @raw     = ""
          end

          def bank_signature_valid?
            data_string = generate_fields_for_calc
            result_mac = generate_mac data_string

            mac == result_mac
          end

      end
    end
  end
end
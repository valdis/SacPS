module SacPS
  module Auth
    module Nordea
      class Helper
        attr_reader :fields

        include SacPS::Auth::Common
        include SacPS::Auth::Nordea

        def initialize options={}
          @options = {}
          @fields = {}

          @options['A01Y_RCVID'] = SacPS::Auth::Nordea.identifier
          @options['A01Y_LANGCODE'] = options[:language] || "LV"
          @options['A01Y_RETLINK'] = SacPS::Auth::Nordea.return_url
          @options['A01Y_CANLINK'] = SacPS::Auth::Nordea.cancel_url
          @options['A01Y_REJLINK'] = SacPS::Auth::Nordea.fail_url

          add_required_params
          add_mac
        end

        def form_fields
          @fields
        end

        def add_required_params
          required_params = SacPS::Auth::Nordea.required_service_params
          required_params.each do |param|
            param_value = (@options.delete(param) || send(param.to_s.downcase)).to_s
            add_field param, encode_to_utf8(param_value)
          end
        end

        def add_field(name, value)
          return if name.blank? || value.blank?
          @fields[name.to_s] = value.to_s
        end

        def add_mac
          formatted_fields = fields_for_signature
          add_field 'A01Y_MAC', generate_mac(formatted_fields)
        end

        def a01y_action_id
          '701'
        end

        def a01y_vers
          '0002'
        end

        def a01y_stamp
          Time.now.strftime("%Y%m%d%H%M%S%6N")
        end

        def a01y_idtype
          '02'
        end

        def a01y_keyvers 
          '0001'
        end

        def a01y_alg
          '01'          
        end

        private
          def fields_for_signature
            result = ""
            @fields.each {|key, value| result << "#{value}&"}
            result << "#{SacPS::Auth::Nordea.mac}&"
            return result
          end

          def generate_mac fields
            data = OpenSSL::Digest::MD5.hexdigest(fields).upcase
            puts data
            data
          end

      end
    end
  end
end
module SacPS
  module Auth
    module Swedbank
      class Helper
        attr_reader :fields
        include SacPS::Auth::Common
        include SacPS::Auth::Banklink

        # VK_SERVICE
        # VK_VERSION
        # VK_SND_ID
        # VK_REC_ID
        # VK_NONCE
        # VK_RETURN
        # VK_MAC
        # VK_ENCODING
        def initialize options={}
          @options = {}
          @fields = {}
          
          @options['VK_SND_ID'] = SacPS::Auth::Swedbank.identifier
          @options['VK_REC_ID'] = SacPS::Auth::Swedbank.identifier
          @options['VK_RETURN'] = SacPS::Auth::Swedbank.return_url
          @options['VK_NONCE'] = generate_random_string 50
          @options['VK_LANG'] = options[:language] || "LAT"

          add_required_params
          add_mac
          add_lang
          add_encoding
        end

        def form_fields
          @fields
        end

        def add_required_params
          required_params = SacPS::Auth::Swedbank.required_service_params[vk_service]
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
          add_field('VK_MAC', generate_mac(vk_service, form_fields, SacPS::Auth::Swedbank.required_service_params))
        end

        def add_lang
          add_field('VK_LANG', @options['VK_LANG'])
        end

        def add_version
          add_field 'VK_VERSION', vk_version
        end

        def add_encoding
          add_field 'VK_ENCODING', 'UTF-8'
        end

        def vk_version
          '008'
        end

        def vk_service
          4002
        end

        def redirect_url
          SacPS::Auth::Swedbank.service_url
        end

      end
    end
  end
end
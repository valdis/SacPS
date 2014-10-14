module SacPS
  module Auth
    module Dnb
      class Helper
        attr_reader :fields
        include SacPS::Auth::Common
        include SacPS::Auth::Banklink

        # VK_SERVICE
        # VK_VERSION
        # VK_SND_ID
        # VK_STAMP
        # VK_RETURN
        # VK_MAC
        # VK_LANG

        def initialize options={}
          @options = {}
          @fields = {}

          @options['VK_SND_ID'] = SacPS::Auth::Dnb.identifier
          @options['VK_RETURN'] = SacPS::Auth::Dnb.return_url
          @options['VK_STAMP'] = generate_random_string 30
          @options['VK_LANG'] = options[:language] || "LAT"

          add_required_params
          add_mac
          add_lang
        end

        def form_fields
          @fields
        end

        def add_required_params
          required_params = SacPS::Auth::Dnb.required_service_params[vk_service]
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
          add_field('VK_MAC', generate_mac(vk_service, form_fields, SacPS::Auth::Dnb.required_service_params))
        end

        def add_lang
          add_field('VK_LANG', @options['VK_LANG'])
        end

        def vk_version
          101
        end

        def vk_service
          3001
        end

      end
    end
  end
end
module SacPS
  module Auth
    module Seb
      class Helper
        attr_reader :fields
        include SacPS::Auth::Common
        include SacPS::Auth::Banklink

        # IB_SND_ID:SLF
        # IB_SERVICE:0005
        # IB_LANG:LAT

        def initialize options={}
          @options = {}
          @fields = {}
          
          @options['IB_LANG'] = options[:language] || "LAT"

          add_required_params
        end

        def add_required_params
          required_params = SacPS::Auth::Seb.required_service_params
          required_params.each do |param|
            param_value = (@options.delete(param) || send(param.to_s.downcase)).to_s
            add_field param, encode_to_utf8(param_value)
          end
        end
        
        def add_field(name, value)
          return if name.blank? || value.blank?
          @fields[name.to_s] = value.to_s
        end

        def form_fields
          @fields
        end

        def ib_snd_id
          SacPS::Auth::Seb.identifier
        end

        def ib_service
          '0005'
        end

      end
    end
  end
end
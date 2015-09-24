module SacPS
  module Auth
    module DraugiemId
      class Helper
        attr_accessor :authentication_url

        def initialize
          SacPS::Auth::DraugiemId.validate_config!
          @authentication_url = build_authentication_url
        end

        def build_authentication_url
          app = SacPS::Auth::DraugiemId.app_id
          hash = build_control_code
          redirect = SacPS::Auth::DraugiemId.return_url
          "https://api.draugiem.lv/authorize/?app=#{app}&hash=#{hash}&redirect=#{redirect}"
        end

        def build_control_code
          Digest::MD5.hexdigest("#{SacPS::Auth::DraugiemId.app_id}#{SacPS::Auth::DraugiemId.return_url}")
        end

      end
    end
  end
end

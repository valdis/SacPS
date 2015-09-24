module SacPS
  module Auth
    module DraugiemId
      class Notification
        attr_accessor :user_identifier, :user_name

        def initialize(dr_auth_code)
          SacPS::Auth::DraugiemId.validate_config!
          authorize!
          request_user_data!          
        end

        def authorize!

        end

        def request_user_data!

        end


      end
    end
  end
end

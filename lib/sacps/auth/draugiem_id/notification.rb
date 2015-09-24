require 'rest-client'

module SacPS
  module Auth
    module DraugiemId
      class Notification
        attr_accessor :dr_auth_code, :auth_response, :user_apikey, :user_data_response, :user_identifier, :user_name

        def self.perform_complete_stack!(dr_auth_code)
          notification = self.new(dr_auth_code)
          notification.authorize!
          notification.request_user_data!
          notification.parse_user_data!
          return notification
        end

        def initialize(dr_auth_code)
          SacPS::Auth::DraugiemId.validate_config!
          @dr_auth_code = dr_auth_code
        end

        def authorize!
          uri = SacPS::Auth::DraugiemId.api_url
          params = {params: {action: "authorize", app: SacPS::Auth::DraugiemId.app_key, code: @dr_auth_code} }
          response = RestClient.get(uri, params)
          response = JSON.parse(response)
          raise %Q|SacPS::Auth::DraugiemId\n#{response["error"]}| if response["error"].present?
          @auth_response = response
          @user_apikey = @auth_response["apikey"]
          return response
        end

        def request_user_data!
          uri = SacPS::Auth::DraugiemId.api_url
          params = {params: {action: "userdata", app: SacPS::Auth::DraugiemId.app_key, apikey: @user_apikey} }
          response = RestClient.get(uri, params)
          response = JSON.parse(response)
          raise %Q|SacPS::Auth::DraugiemId\n#{response["error"]}| if response["error"].present?
          @user_data_response = response
          return response
        end

        def parse_user_data!
          user_hash = @user_data_response["users"].values.first
          @user_identifier = user_hash["pk"]
          @user_name = "#{user_hash["name"]} #{user_hash["surname"]}"
        end

      end
    end
  end
end

require 'rest-client'

module SacPS
  module Auth
    module DraugiemId
      class Notification
        attr_accessor :dr_auth_code, :auth_response, :user_identifier, :user_name

        def self.perform_complete_stack!(dr_auth_code)
          notification = self.new(dr_auth_code)
          notification.authorize!
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
          raise %Q|SacPS::Auth::DraugiemId::Notification\n#{response["error"]}| if response["error"].present?
          @auth_response = response
          return response
          # @auth_response={"apikey"=>"893622a604f3afe374307e88c8a085c1", "uid"=>"5336961", "language"=>"lv", "users"=>{"5336961"=>{"uid"=>5336961, "name"=>"Augusts", "url"=>"/user/5336961/", "surname"=>"Bautra", "nick"=>"", "emailHash"=>"2ca63b0c1c9d2c91e200ac5b26b28bd1", "place"=>"", "img"=>false, "imgi"=>false, "imgm"=>false, "imgl"=>false, "sex"=>"M", "birthday"=>"1988-11-26", "age"=>26, "adult"=>1, "type"=>"User_Default", "deleted"=>false, "created"=>"24.09.2015 12:28:27", "pk"=>""}}}
        end

        def parse_user_data!
          user_hash = @auth_response["users"].values.first
          @user_identifier = user_hash["pk"]
          raise SacPS::Auth::DraugiemId::NotificationError if @user_identifier.blank?
          @user_name = "#{user_hash["name"]} #{user_hash["surname"]}"
        end

      end

      class NotificationError < StandardError
        def message
          "pk_missing"
        end
      end

    end
  end
end

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

        private
          def emptify!
            @params  = Hash.new
            @raw     = ""
          end
      end
    end
  end
end
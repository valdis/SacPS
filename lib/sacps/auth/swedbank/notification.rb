module SacPS
  module Auth
    module Swedbank
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
          params['VK_INFO']
        end

        def language
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
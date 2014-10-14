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
          "PERSON:#{params['VK_PER_CODE']};NAME:#{params['VK_PER_FNAME']} #{params['VK_PER_LNAME']}"
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
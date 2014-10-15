module SacPS
  module Auth
    module Nordea
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
          "PERSON:#{params['B02K_CUSTID']};NAME:#{params['B02K_CUSTNAME']}"
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
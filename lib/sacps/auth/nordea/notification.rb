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
          identifier = params['B02K_CUSTID']

          identifier = identifier.split(//).first(6).join+"-"+identifier.split(//).last(5).join

          "#{identifier};#{params['B02K_CUSTNAME']}"
        end

        def user_identifier
          user_information.split(";").first
        end

        def user_name
          user_information.split(";").last
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
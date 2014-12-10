require 'sacps/auth/banklink'
require 'sacps/auth/seb/helper'
require 'sacps/auth/seb/notification'

module SacPS
  module Auth
    module Seb
      mattr_accessor :identifier
      mattr_accessor :service_url
      mattr_accessor :required_service_params

      def self.notification post
        Notification.new post
      end

      def self.helper options={}
        Helper.new options
      end

      self.required_service_params = {
        '0005' => [
          'IB_SND_ID',
          'IB_SERVICE',
          'IB_LANG',
        ],
      }

    end
  end
end
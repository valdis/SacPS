require 'sacps/auth/nordea/helper'
require 'sacps/auth/nordea/notification'

module SacPS
  module Auth
    module Nordea
      mattr_accessor :mac
      mattr_accessor :identifier
      mattr_accessor :service_url
      mattr_accessor :return_url
      mattr_accessor :cancel_url
      mattr_accessor :fail_url

      mattr_accessor :required_service_params
      mattr_accessor :required_response_params_for_mac_calc

      def self.notification post
        Notification.new post
      end

      def self.helper options={}
        Helper.new options
      end

      def generate_mac fields
        OpenSSL::Digest::MD5.hexdigest(fields).upcase
      end

      self.required_service_params = [
        'A01Y_ACTION_ID',
        'A01Y_VERS',
        'A01Y_RCVID',
        'A01Y_LANGCODE',
        'A01Y_STAMP',
        'A01Y_IDTYPE',
        'A01Y_RETLINK',
        'A01Y_CANLINK',
        'A01Y_REJLINK',
        'A01Y_KEYVERS',
        'A01Y_ALG'
      ]

      self.required_response_params_for_mac_calc = [
        'B02K_VERS',
        'B02K_TIMESTMP',
        'B02K_IDNBR',
        'B02K_STAMP',
        'B02K_CUSTNAME',
        'B02K_KEYVERS',
        'B02K_ALG',
        'B02K_CUSTID',
        'B02K_CUSTTYPE'
      ]
    end
  end
end
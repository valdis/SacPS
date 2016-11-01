require 'sacps/auth/banklink'
require 'sacps/auth/seb/helper'
require 'sacps/auth/seb/notification'

module SacPS
  module Auth
    module Seb
      mattr_accessor :identifier
      mattr_accessor :service_url
      mattr_accessor :required_service_params
      mattr_accessor :public_key
      mattr_accessor :private_key
      mattr_accessor :bank_public_key

      def self.notification post
        Notification.new post
      end

      def self.helper options={}
        Helper.new options
      end

      self.required_service_params = {
        '0001' => [
          'IB_SND_ID',
          'IB_SERVICE',
          'IB_REC_ID',
          'IB_USER',
          'IB_DATE',
          'IB_TIME',
          'IB_USER_INFO',
          'IB_VERSION',
        ],
        '0005' => [
          'IB_SND_ID',
          'IB_SERVICE',
          'IB_LANG',
        ],
      }

      def self.get_public_key
        cert = self.public_key
        OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
      end

      def self.get_private_key
        private_key = self.private_key
        OpenSSL::PKey::RSA.new(private_key.gsub(/  /, ''))
      end

      def self.get_bank_public_key
        cert = self.bank_public_key
        OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
      end

    end
  end
end

require 'sacps/auth/banklink'
require 'sacps/auth/dnb/helper'
require 'sacps/auth/dnb/notification'

module SacPS
  module Auth
    module Dnb
      mattr_accessor :public_key
      mattr_accessor :private_key
      mattr_accessor :identifier
      mattr_accessor :service_url
      mattr_accessor :return_url
      mattr_accessor :required_service_params

      def self.get_public_key
        cert = self.public_key
        OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
      end

      def self.get_private_key
        private_key = self.private_key
        OpenSSL::PKey::RSA.new(private_key.gsub(/  /, ''))
      end

      def self.notification post
        Notification.new post
      end

      def self.helper options={}
        Helper.new options
      end

      self.required_service_params = {
        3001 => [
          'VK_SERVICE',
          'VK_VERSION',
          'VK_SND_ID',
          'VK_STAMP',
          'VK_RETURN',
          ],
        2001 => [
          'VK_SERVICE',
          'VK_VERSION',
          'VK_SND_ID',
          'VK_REC_ID',
          'VK_STAMP',
          'VK_T_NO',
          'VK_PER_CODE',
          'VK_PER_FNAME',
          'VK_PER_LNAME',
          'VK_TIME',
          'VK_LANG'
        ]
      }

    end
  end
end
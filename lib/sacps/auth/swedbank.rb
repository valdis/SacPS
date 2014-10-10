require 'sacps/auth/swedbank/helper'
require 'sacps/auth/swedbank/notification'

module SacPS
  module Auth
    module Swedbank

      mattr_accessor :bank_certificate
      mattr_accessor :private_key
      mattr_accessor :required_service_params
      mattr_accessor :service_url

      def self.get_public_key
        cert = self.bank_certificate
        OpenSSL::X509::Certificate.new(cert.gsub(/  /, '')).public_key
      end

      def self.get_private_key
        private_key = self.private_key
        OpenSSL::PKey::RSA.new(private_key.gsub(/  /, ''))
      end

      def self.notification(post)
        Notification.new(post)
      end

      def self.helper(order, account, options = {})
        Helper.new(order, account, options)
      end

      self.required_service_params = {
        4002 => [
          'VK_SERVICE',
          'VK_VERSION',
          'VK_SND_ID',
          'VK_REC_ID',
          'VK_NONCE',
          'VK_RETURN',
          'VK_MAC',
          'VK_ENCODING'
          ]
        }

    end
  end
end
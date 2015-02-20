require 'sacps/auth/citadele/helper'
require 'sacps/auth/citadele/notification'

module SacPS
  module Auth
    module Citadele

      require 'xmldsig'

      mattr_accessor :service_url, :return_url, :identifier, :public_key, :private_key

      SacPS::Auth::Citadele.service_url = "https://online.citadele.lv/amai/start.htm"
      SacPS::Auth::Citadele.return_url = "https://your-domain.com/auth/citadele"
      SacPS::Auth::Citadele.identifier = "13091" # Your merchant number with Citadele

      def self.notification post
        Notification.new post
      end

      def self.helper
        Helper.new
      end

      def self.get_public_key
        OpenSSL::X509::Certificate.new(SacPS::Auth::Citadele.public_key).public_key
      end

      def self.get_private_key
        OpenSSL::PKey::RSA.new(SacPS::Auth::Citadele.private_key)
      end

    end
  end
end

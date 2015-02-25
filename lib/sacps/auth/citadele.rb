require 'sacps/auth/citadele/helper'
require 'sacps/auth/citadele/notification'
require 'sacps/auth/citadele/xml_builder'

module SacPS
  module Auth
    module Citadele

      require 'Nokogiri'
      require 'xmldsig'

      mattr_accessor :service_url, :return_url, :identifier, :private_key, :private_cert, :public_key

      SacPS::Auth::Citadele.private_key = ENV["CITADELE_PRIVKEY"]
      SacPS::Auth::Citadele.private_cert = ENV["CITADELE_PRIVATE_CERT"]
      SacPS::Auth::Citadele.service_url = "https://online.citadele.lv/amai/start.htm"
      SacPS::Auth::Citadele.return_url  = "https://your-domain.com/auth/citadele"
      SacPS::Auth::Citadele.identifier  = ENV["CITADELE_IDENTIFIER"] # Your merchant number with Citadele


      def self.validate_config
        if SacPS::Auth::Citadele.private_key.blank? ||
        SacPS::Auth::Citadele.private_cert.blank? ||
        SacPS::Auth::Citadele.public_key.blank?
          raise "Citadele init contains blank values, review README"
        end
      end

      def self.notification xml
        Notification.new xml
      end

      def self.helper
        Helper.new
      end

      def self.get_public_key
        OpenSSL::X509::Certificate.new(SacPS::Auth::Citadele.public_key)
      end

      def self.get_private_key
        OpenSSL::PKey::RSA.new(SacPS::Auth::Citadele.private_key)
      end

    end
  end
end

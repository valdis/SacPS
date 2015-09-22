module SacPS
  module Auth
    module Citadele
      require 'xmldsig'

      mattr_accessor :service_url, :return_url, :identifier, :private_key, :private_cert, :public_key

      require 'sacps/auth/citadele/helper'
      require 'sacps/auth/citadele/notification'
      require 'sacps/auth/citadele/helper_xml_builder'
      require 'sacps/auth/citadele/notification_xml_builder'

      def self.set_default_values
        SacPS::Auth::Citadele.identifier   ||= ENV["CITADELE_IDENTIFIER"] # Your merchant number with Citadele
        SacPS::Auth::Citadele.private_key  ||= ENV["CITADELE_PRIVKEY"]
        SacPS::Auth::Citadele.private_cert ||= ENV["CITADELE_PRIVATE_CERT"]
        SacPS::Auth::Citadele.public_key   ||= ENV["CITADELE_PUBLIC_KEY"] || File.read("#{SacPS.root}/lib/sacps/auth/citadele/public_key")
        SacPS::Auth::Citadele.return_url   ||= "https://your-domain.com/auth/citadele"
        SacPS::Auth::Citadele.service_url  ||= "https://online.citadele.lv/amai/start.htm"
      end

      def self.validate_config!
        self.set_default_values
        message = []
        if SacPS::Auth::Citadele.private_key.blank?
          message << "No Private Key!"
        end
        if SacPS::Auth::Citadele.private_cert.blank?
          message << "No Private Cert!"
        end
        if SacPS::Auth::Citadele.public_key.blank?
          message << "No Public Key!"
        end
        raise "Citadele init contains blank values, review README. Errors:\n#{message.join("\n")}" if message.any?
      end

      def self.helper
        Helper.new
      end

      def self.helper2
        Helper2.new
      end

      def self.notification xml
        Notification.new xml
      end

      def self.get_public_key
        OpenSSL::X509::Certificate.new(SacPS::Auth::Citadele.public_key)        
      end

      def self.get_private_key
        OpenSSL::PKey::RSA.new(SacPS::Auth::Citadele.private_key)
      end

      def self.get_private_cert
        SacPS::Auth::Citadele.private_cert.strip_crypto_wrappers.gsub("\n", '')
      end

    end
  end
end

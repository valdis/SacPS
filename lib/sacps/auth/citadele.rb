require 'sacps/auth/citadele/helper'
require 'sacps/auth/citadele/notification'

module SacPS
  module Auth
    module Citadele
      mattr_accessor :bank_certificate
      mattr_accessor :private_key
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

      def self.helper(account, options = {})
        Helper.new(account, options)
      end

      def canonicalize xml
        xmldoc = Nokogiri::XML(xml, nil, nil, Nokogiri::XML::ParseOptions::NOBLANKS | Nokogiri::XML::ParseOptions::NOCDATA | Nokogiri::XML::ParseOptions::STRICT)
        return xmldoc.canonicalize
      end

      def generate_signature
        
        # privkey = self.get_private_key
        # privkey.sign(OpenSSL::Digest::SHA1.new, generate_data_string(service_msg_number, sigparams, required_service_params))
      end

      
    end
  end
end  

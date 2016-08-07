module SacPS
  module Auth
    module Banklink
      def generate_signature(service_msg_number, sigparams, required_service_params)
        private_key = self.class.parent.get_private_key
        data_string = generate_data_string(service_msg_number, sigparams, required_service_params)
        signature = private_key.sign(OpenSSL::Digest::SHA1.new, data_string)
        signature
      end

      def generate_mac(service_msg_number, sigparams, required_service_params)
        vk_mac = Base64.encode64(generate_signature(service_msg_number, sigparams, required_service_params)).gsub(/\n/,'')
        vk_mac
      end
    end
  end
end

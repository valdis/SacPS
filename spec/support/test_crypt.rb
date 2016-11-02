class TestCrypt

  def initialize(private_key_path:)
    @private_key = read_private_key(private_key_path)
    # @public_key  = extract_public_key(bank_certificate_path)
    @digest = OpenSSL::Digest::SHA1.new
  end

  def sign message
    signature = @private_key.sign(@digest, message)
    Base64::encode64(signature).rstrip
  end

  def calc_mac_signature(params, required_fields)
    mac = prepair_mac_string(params, required_fields)
    enc_mac = sign(mac)
    enc_mac
  end

  def generate_signature_param(params, required_fields)
    CGI.escape(calc_mac_signature(params, required_fields))
  end

  class << self
    def to_params(valid_http_raw_data)
      params_array = valid_http_raw_data.split('&').map{|i| i.split('=', 2)}
      Hash[params_array.map{|key, value| [key, value]}]
    end

    def to_query(params)
      params.collect{ |k, v| "#{k}=#{v}" }.join('&')
    end
  end

  private

  def prepair_mac_string(post, required_fields)
    mac = ""
    required_fields.each{|field|
      post[field] = post[field].to_s.strip
      mac += post[field].to_s.chars.count.to_s.rjust(3,"0") + post[field].to_s
    }
    mac
  end

  def read_private_key key_path
    OpenSSL::PKey::RSA.new File.read(key_path)
  end

  def extract_public_key cert_path
    OpenSSL::X509::Certificate.new(File.read(cert_path).gsub(/  /, "")).public_key
  end
end

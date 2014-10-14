require "builder"
require "nokogiri"

module SacPS
  module Auth
    module Citadele
      class Helper
        attr_reader :fields

        include SacPS::Auth::Common
        include SacPS::Auth::Citadele

        def initialize options={}
          @options = {}
          @fields = {}
          
          @options['from'] = SacPS::Auth::Citadele.identifier
          @options['timestamp'] = Time.now.strftime("%Y%m%d%H%M%S%3N")
          @options['request'] = request
          @options['requestUID'] = generate_random_string 30
          @options['return_url'] = SacPS::Auth::Citadele.return_url
          @options['language'] = options[:language] || "LV"

          @doc = build_xml
          @doc, @built_valid_xml = sign_xml @doc
          form_signature_ds!
          canonicalize!
          puts @doc
        end

        def valid?
          @built_valid_xml
        end

        def xml
          @doc
        end

        def build_xml
          doc = ""

          xml = Builder::XmlMarkup.new(indent: 1, target: doc)
          xml.instruct!
          xml.FIDAVISTA("xmlns" => "http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance", "xsi:schemaLocation" => "http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1 http://ivis.eps.gov.lv/XMLSchemas/100017/fidavista/v1-1/fidavista.xsd") do
            xml.Header do
              xml.Timestamp @options['timestamp']
              xml.From @options['from']
              xml.Extension do
                xml.Amai("xmlns" => "http://online.citadele.lv/XMLSchemas/amai/", "xsi:schemaLocation" => "http://online.citadele.lv/XMLSchemas/amai/ http://online.citadele.lv/XMLSchemas/amai/amai.xsd") do
                  xml.Request @options['request']
                  xml.RequestUID @options['requestUID']
                  xml.Version version
                  xml.Language @options['language']
                  xml.ReturnURL @options['return_url']
                  xml.SignatureData do
                    build_signature xml
                  end
                end  
              end
            end
          end

          return doc
        end

        def build_signature xml
          xml.Signature("xmlns" =>"http://www.w3.org/2000/09/xmldsig#") do
            xml.SignedInfo do
              xml.CanonicalizationMethod "Algorithm"=>"http://www.w3.org/TR/2001/REC-xml-c14n-20010315"
              xml.SignatureMethod "Algorithm" => "http://www.w3.org/2000/09/xmldsig#rsa-sha1"
              xml.Reference "URI" => "" do
                
                xml.Transforms do
                  xml.Transform("Algorithm"=>"http://www.w3.org/2000/09/xmldsig#enveloped-signature")
                end

                xml.DigestMethod("Algorithm"=>"http://www.w3.org/2000/09/xmldsig#sha1")
                xml.DigestValue

              end
            end
            xml.SignatureValue

            xml.KeyInfo do
              xml.X509Data do
                xml.X509Certificate get_public_key_as_string 
              end
            end
          end
        end

        def form_signature_ds!
          ["Signature", "SignedInfo", "CanonicalizationMethod", "Reference", "Transforms", "Transform", "DigestMethod", "DigestValue", "KeyInfo", "X509Data", "X509Certificate"].each do |signature_data| 
            @doc = @doc.gsub(signature_data, "ds:#{signature_data}")
          end
          @doc = @doc.gsub "ds:SignatureData", "SignatureData"
          @doc = @doc.gsub "ds:ds:", "ds:"
        end

        def canonicalize!
          doc = Nokogiri::XML(@doc, nil, nil, Nokogiri::XML::ParseOptions::NOBLANKS | Nokogiri::XML::ParseOptions::NOCDATA | Nokogiri::XML::ParseOptions::STRICT).canonicalize
          xml = '<?xml version="1.0" encoding="UTF-8"?>' + "\n"
          doc.split(/\r?\n/).each {|line| xml << line}
          @doc = xml
        end

        def version
          "3.0"
        end

        def request
          "AUTHREQ"
        end

      end
    end
  end
end
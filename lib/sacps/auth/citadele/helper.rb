require "builder"
require "nokogiri"

module SacPS
  module Auth
    module Citadele
      class Helper
        attr_reader :fields
        include SacPS::Auth::Common
        include SacPS::Auth::Citadele

        def initialize(account, options={})
          @options = {}
          @fields = {}
          
          @options['from'] = account
          @options['timestamp'] = Time.now.strftime("%Y%m%d%H%M%S%3N")
          @options['request'] = "AUTHREQ"
          @options['requestUID'] = generate_random_string 30
          @options['return_url'] = options[:return]
          @options['language'] = options[:language] || "LV"

          @doc = build_xml
          puts @doc
          puts "___________"
          canonicalize_doc!
          puts @doc
        end

        def form_fields
          @fields
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
                  xml.SignatureData
                end  
              end
            end
          end

          return doc
        end

        def canonicalize_doc!
          @doc = Nokogiri::XML(@doc, nil, nil, Nokogiri::XML::ParseOptions::NOBLANKS | Nokogiri::XML::ParseOptions::NOCDATA | Nokogiri::XML::ParseOptions::STRICT).canonicalize
        end


        def version
          "2.0"
        end

      end
    end
  end
end
module SacPS
  module Auth
    module Citadele
      class Notification

        attr_reader :xml, :message, :user_identifier, :user_name, :from, :uuid, :digest
        attr_accessor :response_hash, :code, :recalculated_digest

        def initialize(xml)
          SacPS::Auth::Citadele.validate_config!
          @xml = xml.gsub("&quot;", '"')
          @response_hash = parse_response(@xml)
          @code = @response_hash["Code"]
          @message = @response_hash["Message"]
          @uuid = @response_hash["RequestUID"]
          @digest = @response_hash["DigestValue"]
          @recalculated_digest = build_digest

          @user_identifier = @response_hash["PersonCode"].split("").insert(6,"-").join #=> "123456-12345"
          @user_name       = @response_hash["Person"].split(" ").rotate.join(" ") #=> "JĀNIS BĒRZIŅŠ"
          @from            = "CITADELE"
        end

        def user_information
          "#{@user_identifier};#{@user_name}"
        end

        def valid?
          return code_ok? && digest_ok? && cert_ok? && timestamp_ok? && signature_ok?
        end

        def code_ok?
          return @code == "100"
        end

        def cert_ok?
          # puts %Q|server pubkey contents are:\n|
          # puts SacPS::Auth::Citadele.public_key.inspect

          # puts %Q|response_hash["SignatureCert"] contents are:\n|
          # puts response_hash["SignatureCert"].inspect
          begin
            response_cert_as_text = OpenSSL::X509::Certificate.new( response_hash["SignatureCert"] ).to_text
            # puts SacPS::Auth::Citadele.public_key.strip == response_hash["SignatureCert"].strip
            # puts response_cert_as_text.match("Citadele Banka AS").present?

            SacPS::Auth::Citadele.public_key.strip == response_hash["SignatureCert"].strip &&
            response_cert_as_text.match("Citadele Banka AS").present?
          rescue
            false
          end
        end

        def digest_ok?
          # TO-DO Calculate digest for response
          puts digest
          puts recalculated_digest
          digest == recalculated_digest
        end

        def signature_ok?
          decoded_signature = Base64.decode64(response_hash["SignatureValue"])
          if digest_ok?
            return SacPS::Auth::Citadele.get_public_key.public_key.verify(OpenSSL::Digest::SHA1.new, decoded_signature, digest)
          else
            return false
          end
        end

        def timestamp_ok?
          stamp = response_hash["Timestamp"]; stamp_i = stamp.to_datetime.to_i
          now   = Time.now.strftime("%Y%m%d%H%M%S%3N"); now_i = now.to_datetime.to_i

          # puts "Stamp: #{stamp} | Interger value: #{stamp_i}"
          # puts "Now:   #{now} | Interger value: #{now_i}"

          now_later_than_stamp = (now_i - stamp_i) > 0
          now_within_900_seconds_of_stamp = (now_i - stamp_i) < 900

          # puts "Now is later than stamp: #{now_later_than_stamp}"
          # puts "Now is within 900s stamp: #{now_within_900_seconds_of_stamp}"

          return now_later_than_stamp && now_within_900_seconds_of_stamp
        end

        private

          def parse_response xml
            doc = Nokogiri::XML(xml) do |config|
              config.strict.nonet
            end
            doc.remove_namespaces!

            return {
              "Timestamp" => doc.xpath("//Timestamp").text,
              "From" => doc.xpath("//From").text,
              "Request" => doc.xpath("//Request").text,
              "RequestUID" => doc.xpath("//RequestUID").text,
              "Version" => doc.xpath("//Version").text,
              "Language" => doc.xpath("//Language").text,
              "PersonCode" => doc.xpath("//PersonCode").text,
              "Person" => doc.xpath("//Person").text,
              "Code" => doc.xpath("//Code").text, # Important
              "Message" => doc.xpath("//Message").text,
              "DigestValue" => doc.xpath("//DigestValue").text,
              "SignatureValue" => doc.xpath("//SignatureValue").text.strip,
              "SignatureCert" => doc.xpath("//X509Certificate").text.strip
              }
          end

          # def build_hashable_string
          #   rh = @response_hash
          #   return "#{rh["Timestamp"]}#{rh["From"]}#{rh["Request"]}#{rh["RequestUID"]}#{rh["Version"]}#{rh["Language"]}#{rh["PersonCode"]}#{rh["Person"]}#{rh["Code"]}#{rh["Message"]}"
          # end

      end # -- Ends class
    end
  end
end
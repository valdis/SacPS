# module SacPS
#   module Auth
#     module Citadele
#       class Helper

#         HELPER_LINE = %Q|      <Amai xmlns="http://online.citadele.lv/XMLSchemas/amai/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://online.citadele.lv/XMLSchemas/amai/http://online.citadele.lv/XMLSchemas/amai/amai.xsd">|

#         def return_signed_request_xml
#           xml = <<-XML.unindent
#           <?xml version="1.0" encoding="UTF-8" ?>
#           <FIDAVISTA xmlns="#{@ivis_url}" #{@schema_attribute} xsi:schemaLocation="#{@ivis_url} #{@ivis_url}/fidavista.xsd">
#             <Header>
#               <Timestamp>#{@timestamp}</Timestamp>
#               <From>#{@identifier}</From>
#               <Extension>
#                 <Amai xmlns="#{@amai_url}" #{@schema_attribute} xsi:schemaLocation="#{@amai_url} #{@amai_url}amai.xsd">
#                   <Request>#{@request}</Request>
#                   <RequestUID>#{@uuid}</RequestUID>
#                   <Version>#{@version}</Version>
#                   <Language>#{@language}</Language>
#                   <ReturnURL>#{@return_url}</ReturnURL>
#                   <SignatureData>
#                     <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
#                       <SignedInfo>
#                         <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
#                         <SignatureMethod #{@xmldsig_attribute}rsa-sha1"/>
#                         <Reference>
#                           <Transforms>
#                             <Transform #{@xmldsig_attribute}enveloped-signature"/>
#                           </Transforms>
#                           <DigestMethod #{@xmldsig_attribute}sha1"/>
#                           <DigestValue>#{@digest}</DigestValue>
#                         </Reference>
#                       </SignedInfo>
#                       <SignatureValue>#{@signature}</SignatureValue>
#                       <KeyInfo>
#                         <X509Data>
#                           <X509Certificate>#{SacPS::Auth::Citadele.private_cert.gsub("\n",'')}</X509Certificate>
#                         </X509Data>
#                       </KeyInfo>
#                     </Signature>
#                   </SignatureData>
#                 </Amai>
#               </Extension>
#             </Header>
#           </FIDAVISTA>
#           XML

#           clean_xml = xml.strip
#           doc = Nokogiri::XML(clean_xml) { |config| config.strict }
#           canonicalized_array = doc.canonicalize.split("\n")
#           canonicalized_array[5] = HELPER_LINE
#           #puts "^^^^^^^^^"
#           return %Q|<?xml version="1.0" encoding="UTF-8" ?>\n| + canonicalized_array.join("\n") # kanonizēts plus xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ?
#           #return clean_xml
#           # canonicalized version can not be returned since it cuts off
#           # <?xml version="1.0" encoding="UTF-8" ?>
#           # Maybe canonicalize and re-add it?
#         end


#         private

#           def build_unsigned_request_xml
#             xml = <<-XML.unindent
#             <FIDAVISTA xmlns="#{@ivis_url}" #{@schema_attribute} xsi:schemaLocation="#{@ivis_url} #{@ivis_url}/fidavista.xsd">
#               <Header>
#                 <Timestamp>#{@timestamp}</Timestamp>
#                 <From>#{@identifier}</From>
#                 <Extension>
#                   <Amai xmlns="#{@amai_url}" #{@schema_attribute} xsi:schemaLocation="#{@amai_url} #{@amai_url}amai.xsd">
#                     <Request>#{@request}</Request>
#                     <RequestUID>#{@uuid}</RequestUID>
#                     <Version>#{@version}</Version>
#                     <Language>#{@language}</Language>
#                     <ReturnURL>#{@return_url}</ReturnURL>
#                     <SignatureData/>
#                   </Amai>
#                 </Extension>
#               </Header>
#             </FIDAVISTA>
#             XML

#             clean_xml = xml.strip
#             #return Nokogiri::XML(clean_xml) { |config| config.strict }.canonicalize
#             nokogiri_canon_array = Nokogiri::XML(clean_xml) { |config| config.strict }.canonicalize.split("\n")
#             nokogiri_canon_array[5] = HELPER_LINE
#             return nokogiri_canon_array.join("\n")
#           end

#           def build_digest
#             # "Digests ˇˇ"
#             # puts Base64.encode64( OpenSSL::Digest::SHA1.digest(@unsigned_xml_part) ).strip
#             # puts Base64.encode64( OpenSSL::Digest::SHA1.digest(@unsigned_xml_part.gsub(/\A\s+/, '')) ).strip
#             Base64.encode64( OpenSSL::Digest::SHA1.digest(@unsigned_xml_part) ).strip
#           end

#           def build_signed_info
#             signed_info = <<-XML.unindent
#             <SignedInfo>
#               <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
#               <SignatureMethod #{@xmldsig_attribute}rsa-sha1"/>
#               <Reference>
#                 <Transforms>
#                   <Transform #{@xmldsig_attribute}enveloped-signature"/>
#                 </Transforms>
#                 <DigestMethod #{@xmldsig_attribute}sha1"/>
#                 <DigestValue>#{@digest}</DigestValue>
#               </Reference>
#             </SignedInfo>
#             XML

#             clean_xml = signed_info.strip#.lineify
#             return Nokogiri::XML(clean_xml) { |config| config.strict }.canonicalize
#           end

#           def build_signature
#                 privkey = SacPS::Auth::Citadele.get_private_key
#             signed_hash = privkey.sign(OpenSSL::Digest::SHA1.new, @signed_info)
#             return Base64.encode64(signed_hash).strip.gsub("\n", '') # TEST
#           end

#       end
#     end
#   end
# end
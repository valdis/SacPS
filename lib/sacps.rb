require 'sacps/version'

require "base64"
require "active_support/dependencies"
require "active_support/concern"
require "active_support/core_ext"

require 'net/http'
require 'net/https'
require 'uri'

require 'digest'
require 'digest/md5'
require 'openssl'

require 'cgi'

require 'sacps/auth/auth'
  require 'sacps/auth/swedbank'
  require 'sacps/auth/seb'
  require 'sacps/auth/dnb'
  require 'sacps/auth/citadele'
  require 'sacps/auth/nordea'

require 'sacps/pay/pay'
require 'sacps/errors/errors'

class String
  # Strip leading whitespace from each line that is the same as the
  # amount of whitespace on the first line of the string.
  # Leaves _additional_ indentation on later lines intact.
  # USAGE: xml = <<-XML.unindent
  #        XML
  def unindent
    gsub /^#{self[/\A\s*/]}/, ''
  end

  def lineify
    gsub(/\n/,'').gsub(/\>\s+\</, '><')
  end
end

class Hash
  def to_params
    map{ |k, v| URI.escape("#{k}=#{v}") }.join("&")
  end
end

module SacPS
  ROOT = File.expand_path("../..", __FILE__)

  def self.root
    ROOT
  end

end

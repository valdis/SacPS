class String
  # Strip leading whitespace from each line that is the same as the
  # amount of whitespace on the first line of the string.
  # Leaves _additional_ indentation on later lines intact.
  # USAGE: xml = <<-XML.unindent
  #        XML
  def unindent
    gsub(/^#{self[/\A\s*/]}/, '')
  end

  def lineify
    gsub(/\n/,'').gsub(/\>\s+\</, '><')
  end

  def strip_crypto_wrappers
    gsub(/[-]{5}(BEGIN|END).*?[-]{5}/, '').strip
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

require 'sacps/version'

require "base64"
require "active_support"
require "active_support/dependencies"
require "active_support/concern"
require "active_support/core_ext"

require 'net/http'
require 'net/https'
require 'uri'
require 'rest-client'

require 'digest'
require 'digest/md5'
require 'openssl'

require 'cgi'

require 'sacps/base'
require 'sacps/auth'
require 'sacps/pay'

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

require 'sacps/sacps'
require 'sacps/base'
require 'sacps/auth'
require 'sacps/pay'

module SacPS
  ROOT = File.expand_path("../..", __FILE__)

  def self.root
    ROOT
  end

end

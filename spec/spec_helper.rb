require 'bundler/setup'
Bundler.setup

require 'sacps'
require "config"
require 'priscilla'

RSpec.configure do |config|
  # some (optional) config here
  require 'dotenv'
  Dotenv.load
end
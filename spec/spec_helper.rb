require 'bundler/setup'
Bundler.setup

require 'sacps'
require 'priscilla'

RSpec.configure do |config|
  require 'dotenv'
  Dotenv.load
  require "config"
end
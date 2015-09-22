require 'bundler/setup'
Bundler.setup

require 'sacps'
require 'priscilla'
require 'timecop'
require 'pry'

RSpec.configure do |config|
  require 'dotenv'
  Dotenv.load
  require "config"
end

require 'rubygems'
require 'bundler/setup'
require 'savon'
require 'fakeweb'
require "savon/mock/spec_helper"

require 'three_dee_cart' # and any other gems you need
require 'simplecov'
SimpleCov.start

RSpec.configure do |config|
  # some (optional) config here
  FakeWeb.allow_net_connect = false
end

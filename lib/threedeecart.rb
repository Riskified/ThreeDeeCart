require 'threedeecart/config'
require "threedeecart/version"
require 'threedeecart/base'

module Threedeecart

  @@configuration = nil

  def self.load_configuration(config_file)
    @@configurtion = Threedeecart::Config.load_configuration_from_file(config_file)
  end

  def self.config(&block)
    @@configuration = yield(Threedeecart::Config)
  end

  def self.configuration
    @@configuration
  end
end

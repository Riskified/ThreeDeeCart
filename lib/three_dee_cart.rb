require 'three_dee_cart/config'
require "three_dee_cart/version"

module ThreeDeeCart

  @@configuration = nil

  def self.load_configuration(config_file)
    @@configurtion = ThreeDeeCart::Config.load_configuration_from_file(config_file)
  end

  def self.config(&block)
    @@configuration = yield(ThreeDeeCart::Config)
  end

  def self.configuration
    @@configuration
  end
end

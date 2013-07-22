require 'spec_helper'
# require the helper module

describe ThreeDeeCart::Config do
  include Savon::SpecHelper

  describe "#load_configuration_from_file" do

    it "should allow configuration via a file" do
      config_file = File.join(Dir.pwd, "spec", "fixtures", "test_config.yml")
      config = ThreeDeeCart::Config.load_configuration_from_file(config_file)

      config.wsdl.should eq("http://example.com/?wsdl")
    end

    it "should raise an error if the configuration file was not found" do
      config_file = File.join(Dir.pwd, "spec", "fixtures", "missing_file.yml")

      lambda {
        ThreeDeeCart::Config.load_configuration_from_file(config_file)
      }.should raise_error(ThreeDeeCart::Exceptions::MissingConfigurationFile)
    end

    it "should fail if wsdl is not provided" do
      config_file = File.join(Dir.pwd, "spec", "fixtures", "test_config_no_wsdl.yml")
      lambda {
        config = ThreeDeeCart::Config.load_configuration_from_file(config_file)
      }.should raise_error(ThreeDeeCart::Exceptions::MissingWSDL)
    end

  end

  describe "#config" do
    it "should allow configuration by a block" do
      ThreeDeeCart::Config.config do |config|
        config.wsdl = "http://example.com/?wsdl"
        config.api_key = "testtesttest"
      end

      ThreeDeeCart::Config.wsdl.should eq("http://example.com/?wsdl")
    end

    it "should fail if wsdl is not provided" do
      ThreeDeeCart::Config.wsdl = nil
      lambda {
        ThreeDeeCart::Config.config do |config|
          config.api_key = "testtest"
        end
      }.should raise_error(ThreeDeeCart::Exceptions::MissingWSDL)
    end
  end
end
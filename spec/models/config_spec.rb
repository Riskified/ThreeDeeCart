require 'spec_helper'
# require the helper module

describe Threedeecart::Config do
  include Savon::SpecHelper

  describe "#load_configuration_from_file" do

    it "should allow configuration via a file" do
      config_file = File.join(Dir.pwd, "spec", "fixtures", "test_config.yml")
      config = Threedeecart::Config.load_configuration_from_file(config_file)

      config.wsdl.should eq("http://example.com/?wsdl")
    end

    it "should fail if api_key is not provided" do
      config_file = File.join(Dir.pwd, "spec", "fixtures", "test_config_no_api_key.yml")
      lambda {
        config = Threedeecart::Config.load_configuration_from_file(config_file)
      }.should raise_error(Threedeecart::Exceptions::MissingApiKey)
    end

  end

  describe "#config" do
    it "should allow configuration by a block" do
      Threedeecart::Config.config do |config|
        config.wsdl = "http://example.com/?wsdl"
        config.api_key = "testtesttest"
      end

      Threedeecart::Config.wsdl.should eq("http://example.com/?wsdl")
    end

    it "should fail if api_key is not provided" do
      Threedeecart::Config.api_key = nil
      lambda {
        Threedeecart::Config.config do |config|
          config.wsdl = "http://example.com/?wsdl"
        end
      }.should raise_error(Threedeecart::Exceptions::MissingApiKey)
    end
  end
end
require 'spec_helper'

describe ThreeDeeCart do

  describe "#load_configuration" do

    it "should load an existing configration file successfully (real test is in ThreeDeeCart::Config)" do
      config_file = File.join(Dir.pwd, "spec", "fixtures", "test_config.yml")
      config = ThreeDeeCart.load_configuration(config_file)

      ThreeDeeCart.configuration.wsdl.should eq("http://example.com/?wsdl")
    end
  end

  describe "#config" do
    it "should load configuration from block" do
      ThreeDeeCart.config do |config|
        puts config.inspect
        config.wsdl = "http://example.com?wsdl"
        config.api_key = "testtesttest"
      end

      ThreeDeeCart.configuration.wsdl.should eq("http://example.com?wsdl")
      ThreeDeeCart.configuration.api_key.should eq("testtesttest")

    end
  end
end
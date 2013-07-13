require 'spec_helper'
require "savon/mock/spec_helper"

describe ThreeDeeCart::Customer do

  include Savon::SpecHelper
  
  # set Savon in and out of mock mode
  before(:all) { 
    savon.mock!
    ThreeDeeCart.load_configuration("spec/fixtures/test_config.yml")
  }
  after(:all)  { savon.unmock! }

  describe "#find" do
    before(:each) do
      FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "should respond to #find" do
      ThreeDeeCart::Customer.respond_to?(:find).should eq(true)
    end

    it "should return as successful" do
      fixture = File.read("spec/fixtures/getCustomer.xml")

      savon.expects(:get_customer).with({message: {id: 1}}).returns(File.read("spec/fixtures/getCustomer.xml"))
      customer = ThreeDeeCart::Customer.find({id: 1})
      customer.customer_id.to_i.should eq(29)
      customer.shipping_address.first_name.should eq("John")
    end
  end
end
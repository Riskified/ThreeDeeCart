require 'spec_helper'
require "savon/mock/spec_helper"

describe ThreeDeeCart::Request do
  
  include Savon::SpecHelper

  before(:all) {
    savon.mock!
    ThreeDeeCart.load_configuration("spec/fixtures/test_config.yml")
    FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))
  }
  after(:all) { 
    savon.unmock! 
    FakeWeb.clean_registry
  }

  describe "#new" do
    it "should create a valid request instance for a valid operation" do
      expect {
        req = ThreeDeeCart::Request.new(:get_customer, {id: 1})
      }.to_not raise_error
    end

    it "should raise an error for an invalid operation" do
      expect {
        req = ThreeDeeCart::Request.new(:invalid_operation, {id: 1})
      }.to raise_error(ThreeDeeCart::Request::Exceptions::InvalidOperation)
    end
  end

  describe "#invoke" do
    it "should return a valid response hash for a valid request" do
      savon.expects(:get_customer).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getCustomer.xml"))
      @req = nil
      expect {
        @req = ThreeDeeCart::Request.new(:get_customer, {id: 1})
        @req.invoke
      }.to_not raise_error

      expect(@req.hash.keys).to include(:get_customer_response)
    end

    it "should raise an error when WSDL responds with an error xml" do
      
      response = { code: 500, headers: {}, body: File.read("spec/fixtures/api_error.xml") }
      savon.expects(:get_customer).with({message: {id: 1, userKey: "testtesttest"}}).returns(response)
      
      @req = nil
      expect {
        @req = ThreeDeeCart::Request.new(:get_customer, {id: 1})
        @req.invoke
      }.to raise_error(ThreeDeeCart::Request::Exceptions::ApiError)
    end

    it "should raise an error when WSDL responds http error code" do
      
      response = { code: 500, headers: {}, body: File.read("spec/fixtures/getCustomer.xml") }
      savon.expects(:get_customer).with({message: {id: 1, userKey: "testtesttest"}}).returns(response)
      
      @req = nil
      expect {
        @req = ThreeDeeCart::Request.new(:get_customer, {id: 1})
        @req.invoke
      }.to raise_error(ThreeDeeCart::Request::Exceptions::HttpError)
    end

    it "should raise an error when WSDL responds soap fault xml" do
      
      response = { code: 500, headers: {}, body: File.read("spec/fixtures/soap_fault.xml") }
      savon.expects(:get_customer).with({message: {id: 1, userKey: "testtesttest"}}).returns(response)
      
      @req = nil
      expect {
        @req = ThreeDeeCart::Request.new(:get_customer, {id: 1})
        @req.invoke
      }.to raise_error(ThreeDeeCart::Request::Exceptions::SoapError)
    end
  end
end
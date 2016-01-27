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
      expect(ThreeDeeCart::Customer).to respond_to :find
    end

    it "should return as successful" do
      fixture = File.read("spec/fixtures/getCustomer.xml")

      savon.expects(:get_customer).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getCustomer.xml"))
      customer = ThreeDeeCart::Customer.find({id: 1})
      expect(customer.customer_id.to_i).to eq(1)
      expect(customer.shipping_address.first_name).to eq("John")
    end

    it "should return array when multiple customers are returned" do
      savon.expects(:get_customer).with({message: {id: 1, userKey: "testtesttest" }}).returns(File.read("spec/fixtures/getCustomerMultiple.xml"))
      customer = ThreeDeeCart::Customer.find({id: 1})
      expect(customer[0].customer_id.to_i).to eq(1)
      expect(customer[1].customer_id.to_i).to eq(1)
    end
  end

  describe "#edit" do
    before(:each) do
      FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "should respond to #edit" do
      expect(ThreeDeeCart::Customer).to respond_to :edit
    end

    it "should return true when valid customer data" do
      customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", action: :update})
      savon.expects(:edit_customer).with({message: {customerData: customer_data.to_query, action: customer_data.action, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/editCustomer.xml"))

      resp = ThreeDeeCart::Customer.edit(customer_data)
      expect(resp).to be true
    end

    it "should return false when customer data is invalid" do
      customer_data = ThreeDeeCart::CustomerData.new({action: :update})
      resp = ThreeDeeCart::Customer.edit(customer_data)
      expect(resp).to be false
    end

    it "should return false a non successful result is returned" do
      customer_data = ThreeDeeCart::CustomerData.new({contactid: "1", action: :update})
      savon.expects(:edit_customer).with({message: {customerData: customer_data.to_query, action: customer_data.action, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/editCustomerFailure.xml"))

      resp = ThreeDeeCart::Customer.edit(customer_data)
      expect(resp).to be false
    end
  end

  describe "#count" do
    before(:each) do
      FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))
    end

    after(:each) do
      FakeWeb.clean_registry
    end

    it "should respond to #count" do
      expect(ThreeDeeCart::Customer).to respond_to :count
    end

    it "should return as int when successful" do
      savon.expects(:get_customer_count).with({message: {id: 1, userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getCustomerCount.xml"))
      count = ThreeDeeCart::Customer.count({id: 1})
      expect(count).to eq(15473)
    end
  end

  describe "#new" do
    before(:all) do
      @valid_hash = {
      :customer_id => 123,
      :user_id => 1234,
      :password => "123123",
      :last_login_date => "10/10/2012",
      :web_site => "www.google.com",
      :discount_group  => "none",
      :cust_other1 => "bla",
      :account_number => "A123",
      :mail_list => "dunno",
      :customer_type => "5",
      :last_update => "10/10/2012",
      :cust_enabled => true,
      :comments => "fdfsdfds",
      :billing_address => {},
      :shipping_address => {},
      :aditional_fields => {:bla => 1, :bla2 => 2}
    }
    
    @invalid_hash = @valid_hash.merge(:invalid_key => true)

    @hash_with_invalid_shipping_address = @valid_hash.merge(:shipping_address => "string")
    @hash_with_invalid_billing_address = @valid_hash.merge(:billing_address => "string")
    @hash_with_invalid_additional_fields = @valid_hash.merge(:aditional_fields => "string")
    end

    it "should accept a valid hash to constructor" do
      expect {
        @customer = ThreeDeeCart::Customer.new(@valid_hash)
      }.to_not raise_error
    end

    it "should raise an exception for invalid constructor hash value" do
      expect {
        @e_product = ThreeDeeCart::Customer.new(@invalid_hash)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    describe "invalid values for complex enteties" do
      it "should raise an exception for invalid value for categories object" do
        expect {
          @customer = ThreeDeeCart::Customer.new(@hash_with_invalid_shipping_address)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for Extra Fields object" do
        expect {
          @customer = ThreeDeeCart::Customer.new(@hash_with_invalid_billing_address)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end

      it "should raise an exception for invalid value for price levels object" do
        expect {
          @customer = ThreeDeeCart::Customer.new(@hash_with_invalid_additional_fields)
        }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttributeType)
      end
    end
  end
end
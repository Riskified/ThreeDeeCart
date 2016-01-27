require 'spec_helper'
require "savon/mock/spec_helper"

describe ThreeDeeCart::Order do
  include Savon::SpecHelper

  before(:all) { 
    savon.mock!
    ThreeDeeCart.load_configuration("spec/fixtures/test_config.yml")
  
    nori_options = {
      :strip_namespaces     => true,
      :convert_tags_to      => lambda { |tag| tag.snakecase.to_sym },
      :advanced_typecasting => true,
      :parser               => :nokogiri
    }

    doc = File.read("spec/fixtures/getOrder.xml")
    @valid_hash = Nori.new(nori_options).parse(doc)[:envelope][:body][:get_order_response][:get_order_result][:get_orders_response][:order]
    @invalid_hash = {:invalid_attribute => true}
    @valid_order_with_invalid_member = Nori.new(nori_options).parse(doc)[:envelope][:body][:get_order_response][:get_order_result][:get_orders_response][:order]
    @valid_order_with_invalid_member[:shipping_information][:shipment] = {invalid_attr: true}
    
    FakeWeb.register_uri(:get, "http://example.com/?wsdl", :body => File.read("spec/fixtures/wsdl_mock.xml"))

  }
  
  after(:all)  { savon.unmock! }

  describe "#new" do
    it "should accept a valid hash to constructor" do
      expect {
        ThreeDeeCart::Order.new(@valid_hash)
      }.to_not raise_error
    end

    it "should not accept a hash with invalid order attribute" do
      expect {
        ThreeDeeCart::Order.new(@invalid_hash)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end

    it "should not accept a constructor hash that fails on a nested attribute" do
      expect {
        ThreeDeeCart::Order.new(@valid_order_with_invalid_member)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end

  describe "ThreeDeeCart::Order#count" do
    it "should extract the right quantity from a valid response" do
      savon.expects(:get_order_count).with({message: {status: "test", userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getOrderCount.xml"))

      order_count = ThreeDeeCart::Order.count({status: "test"})
      expect(order_count).to eq(474)
    end
  end

  describe "ThreeDeeCart::Order#status" do
    it "should extract the right status from a valid response" do
      savon.expects(:get_order_status).with({message: {invoiceNum: "test", userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getOrderStatus.xml"))
      order_status = ThreeDeeCart::Order.status({invoiceNum: "test", userKey: "testtesttest"})

      expect(order_status[:id]).to eq("1")
      expect(order_status[:status_text]).to eq("New")
    end
  end
 
  describe "ThreeDeeCart::Order#update_status" do
    it "should respond to #update_status" do
      expect(ThreeDeeCart::Order).to respond_to :update_status
    end

    it "should call update status and extract the right status from valid response" do
      savon.expects(:update_order_status).with({message: {invoiceNum: "test", newStatus: "test", userKey: "testtesttest"}}).returns(File.read("spec/fixtures/updateOrderStatus.xml"))
      order_status = ThreeDeeCart::Order.update_status({invoiceNum: "test", newStatus: "test"})
      expect(order_status[:new_status]).to eq("test")
    end
  end

  describe "ThreeDeeCart::Order#update_status" do
    it "should respond to #update_shipment" do
      expect(ThreeDeeCart::Order).to respond_to :update_shipment
    end

    it "should call update shipment and return true" do
      savon.expects(:update_order_shipment).with({message: {invoiceNum: "test", userKey: "testtesttest"}}).returns(File.read("spec/fixtures/updateOrderShipment.xml"))
      resp = ThreeDeeCart::Order.update_shipment({invoiceNum: "test"})
      expect(resp).to be true
    end
  end

  describe "ThreeDeeCart#find" do
    it "should return a valid order for a valid request" do
      savon.expects(:get_order).with({message: {id: "test", userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getOrder.xml"))
      order = ThreeDeeCart::Order.find({id: "test"})
      expect(order.total).to eq("1")
    end

    it "should return a valid order for a valid request with multiple transactions" do
      savon.expects(:get_order).with({message: {id: "test", userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getOrderWithMultipleTransactions.xml"))
      expect {
        order = ThreeDeeCart::Order.find({id: "test"})
      }.to_not raise_error
    end

    it "should return a valid order array for a valid request which returns multiple orders" do
      savon.expects(:get_order).with({message: {id: "test", userKey: "testtesttest"}}).returns(File.read("spec/fixtures/getOrderMultiple.xml"))
      order = ThreeDeeCart::Order.find({id: "test"})
      expect(order[0].total).to eq("1")
      expect(order[1].total).to eq("1")
    end
  end
end
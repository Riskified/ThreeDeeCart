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
    @valid_hash = Nori.new(nori_options).parse(doc)[:get_orders_response][:order]
  }
  
  after(:all)  { savon.unmock! }

  describe "#new" do
    it "should accept a valid hash to constructor" do
      lambda {
        ThreeDeeCart::Order.new(@valid_hash)
      }.should_not raise_error
    end

    it "should not accept a hash with invalid order attribute" do
      pending
    end

    it "should not accept a constructor hash that fails on a nested attribute" do
      pending
    end
  end

  describe "ThreeDeeCart::Order#count" do
    it "should extract the right quantity from a valid response" do
      savon.expects(:get_order_count).with({message: {status: "test"}}).returns(File.read("spec/fixtures/getOrderCount.xml"))

      order_count = ThreeDeeCart::Order.count({status: "test"})
      order_count.should eq(474)
    end
  end

  describe "ThreeDeeCart::Order#status" do
    it "should extract the right status from a valid response" do
      savon.expects(:get_order_status).with({message: {invoiceNum: "test"}}).returns(File.read("spec/fixtures/getOrderStatus.xml"))
      order_status = ThreeDeeCart::Order.status({invoiceNum: "test"})
      order_status[:status_id].should eq("1")
      order_status[:status_text].should eq("New")
    end
  end
end
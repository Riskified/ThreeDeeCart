require 'spec_helper'

describe ThreeDeeCart::Item do
  before(:each) do
    @valid_hash = {
      :shipment_id => 1,
      :warehouse_id => 1,
      :product_id => 1,
      :product_name => "Awesome t-shirt",
      :quantity => 1,
      :unit_price => "40.0",
      :unit_cost => "10.0",
      :option_price => "5.0",
      :weight => "0.00",
      :date_added => "12/10/2013 19:30:50",
      :page_added => "12/10/2013 19:30:51"
    }

    @invalid_hash = {:invalid_attribute => true}
  end

  describe "#new" do
    it "should accept a valid hash into constructor" do
      lambda {
        @item = ThreeDeeCart::Item.new(@valid_hash)
      }.should_not raise_error
    end

    it "should raise an exception for invalid constractor hash" do
      lambda {
        @item = ThreeDeeCart::Item.new(@invalid_hash)
      }.should raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end

  describe "#name" do
    
    before(:each) do
      @item = ThreeDeeCart::Item.new(@valid_hash)
    end

    it "should respond to #name" do
      @item.respond_to?(:name).should be_true
    end

    it "should return product name" do
      @item.name.should eq(@valid_hash[:product_name])
    end
  end

  describe "#price" do
    before(:each) do
      @item = ThreeDeeCart::Item.new(@valid_hash)
    end

    it "should respond to #price" do
      @item.respond_to?(:price).should be_true
    end

    it "should return a float value" do
      @item.price.is_a?(Float).should be_true
    end

    it "should return a valid casting" do
      @item.price.should eq(@valid_hash[:unit_price].to_f)
    end
  end

  describe "#cost" do
    before(:each) do
      @item = ThreeDeeCart::Item.new(@valid_hash)
    end

    it "should respond to #cost" do
      @item.respond_to?(:cost).should be_true
    end

    it "should return a float value" do
      @item.cost.is_a?(Float).should be_true
    end

    it "should return a valid casting" do
      @item.cost.should eq(@valid_hash[:unit_cost].to_f)
    end
  end

  describe "#option_price" do
    before(:each) do
      @item = ThreeDeeCart::Item.new(@valid_hash)
    end

    it "should respond to #cost" do
      @item.respond_to?(:option_price).should be_true
    end

    it "should return a float value" do
      @item.option_price.is_a?(Float).should be_true
    end

    it "should return a valid casting" do
      @item.option_price.should eq(@valid_hash[:option_price].to_f)
    end
  end
end
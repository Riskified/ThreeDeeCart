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
      expect {
        @item = ThreeDeeCart::Item.new(@valid_hash)
      }.to_not raise_error
    end

    it "should raise an exception for invalid constractor hash" do
      expect {
        @item = ThreeDeeCart::Item.new(@invalid_hash)
      }.to raise_error(ThreeDeeCart::Exceptions::InvalidAttribute)
    end
  end

  describe "#name" do
    
    before(:each) do
      @item = ThreeDeeCart::Item.new(@valid_hash)
    end

    it "should respond to #name" do
      expect(@item.respond_to?(:name)).to be true
    end

    it "should return product name" do
      expect(@item.name).to eq(@valid_hash[:product_name])
    end
  end

  describe "#price" do
    before(:each) do
      @item = ThreeDeeCart::Item.new(@valid_hash)
    end

    it "should respond to #price" do
      expect(@item.respond_to?(:price)).to be true
    end

    it "should return a float value" do
      expect(@item.price.is_a?(Float)).to be true
    end

    it "should return a valid casting" do
      expect(@item.price).to eq(@valid_hash[:unit_price].to_f)
    end
  end

  describe "#cost" do
    before(:each) do
      @item = ThreeDeeCart::Item.new(@valid_hash)
    end

    it "should respond to #cost" do
      expect(@item.respond_to?(:cost)).to be true
    end

    it "should return a float value" do
      expect(@item.cost.is_a?(Float)).to be true
    end

    it "should return a valid casting" do
      expect(@item.cost).to eq(@valid_hash[:unit_cost].to_f)
    end
  end

  describe "#option_price" do
    before(:each) do
      @item = ThreeDeeCart::Item.new(@valid_hash)
    end

    it "should respond to #cost" do
      expect(@item).to respond_to :option_price
    end

    it "should return a float value" do
      expect(@item.option_price.is_a?(Float)).to be true
    end

    it "should return a valid casting" do
      expect(@item.option_price).to eq(@valid_hash[:option_price].to_f)
    end
  end
end